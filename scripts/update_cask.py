import hashlib
import json
import os
from pathlib import Path
import re
import urllib.request

REPO = "kanivet-ai/kanivet-oss"
ROOT = Path(__file__).resolve().parents[1]


def latest_release():
    request = urllib.request.Request(
        f"https://api.github.com/repos/{REPO}/releases/latest",
        headers={"Accept": "application/vnd.github+json", "User-Agent": "kanivet-homebrew"},
    )
    if os.environ.get("GH_TOKEN"):
        request.add_header("Authorization", f"Bearer {os.environ['GH_TOKEN']}")
    with urllib.request.urlopen(request, timeout=60) as response:
        return json.load(response)


def release_metadata(release):
    tag = release["tag_name"]
    if release.get("draft") or release.get("prerelease") or not re.fullmatch(r"v\d+\.\d+\.\d+", tag):
        raise ValueError("Expected a published stable semver release")
    version = tag[1:]
    assets = {}
    for arch in ("arm64", "x64"):
        name = f"kanivet-{version}-{arch}-mac.dmg"
        matches = [asset for asset in release["assets"] if asset["name"] == name]
        if len(matches) != 1:
            raise ValueError(f"Expected exactly one asset: {name}")
        asset = matches[0]
        url = f"https://github.com/{REPO}/releases/download/{tag}/{name}"
        if asset["browser_download_url"] != url:
            raise ValueError(f"Unexpected asset URL: {name}")
        digest = asset.get("digest") or ""
        if not re.fullmatch(r"sha256:[0-9a-f]{64}", digest):
            raise ValueError(f"Missing SHA256 digest: {name}")
        if asset.get("size", 0) <= 0:
            raise ValueError(f"Empty asset: {name}")
        assets[arch] = asset
    return version, assets


def render(template, version, assets):
    replacements = [
        (r'(?m)^  version "[^"]+"$', f'  version "{version}"'),
        (r'(?m)^  sha256 arm:   "[^"]+",$', f'  sha256 arm:   "{assets["arm64"]["digest"][7:]}",'),
        (r'(?m)^         intel: "[^"]+"$', f'         intel: "{assets["x64"]["digest"][7:]}"'),
    ]
    for pattern, replacement in replacements:
        template, count = re.subn(pattern, replacement, template)
        if count != 1:
            raise ValueError(f"Expected one cask field: {pattern}")
    return template


def verify_download(asset):
    digest = hashlib.sha256()
    size = 0
    with urllib.request.urlopen(asset["browser_download_url"], timeout=120) as response:
        while chunk := response.read(1024 * 1024):
            digest.update(chunk)
            size += len(chunk)
    if size != asset["size"] or f"sha256:{digest.hexdigest()}" != asset["digest"]:
        raise ValueError(f"Download verification failed: {asset['name']}")
    print(f"Verified {asset['name']}: {digest.hexdigest()}")


def update(release, root=ROOT):
    version, assets = release_metadata(release)
    paths = [root / "Casks/kanivet.rb", root / "official-cask-submission/kanivet.rb"]
    changes = {path: render(path.read_text(), version, assets) for path in paths}
    if all(path.read_text() == text for path, text in changes.items()):
        print(f"Already current: {version}")
        return
    for asset in assets.values():
        verify_download(asset)
    for path, text in changes.items():
        path.write_text(text)
    print(f"Updated casks to {version}")


if __name__ == "__main__":
    update(latest_release())
