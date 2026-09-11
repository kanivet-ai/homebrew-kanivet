import copy
import importlib.util
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

spec = importlib.util.spec_from_file_location("updater", Path(__file__).resolve().parents[1] / "scripts/update_cask.py")
assert spec is not None and spec.loader is not None
updater = importlib.util.module_from_spec(spec)
spec.loader.exec_module(updater)


def release():
    return {
        "tag_name": "v0.1.2", "draft": False, "prerelease": False,
        "assets": [
            {"name": f"kanivet-0.1.2-{arch}-mac.dmg", "size": 100,
             "digest": "sha256:" + digest * 64,
             "browser_download_url": f"https://github.com/{updater.REPO}/releases/download/v0.1.2/kanivet-0.1.2-{arch}-mac.dmg"}
            for arch, digest in [("arm64", "a"), ("x64", "b")]
        ],
    }


class UpdateTests(unittest.TestCase):
    def test_stable_metadata(self):
        version, assets = updater.release_metadata(release())
        self.assertEqual(version, "0.1.2")
        self.assertEqual(set(assets), {"arm64", "x64"})

    def test_invalid_releases(self):
        for change in [{"draft": True}, {"prerelease": True}, {"tag_name": "v0.1.2-rc.1"}, {"tag_name": 'v1.2.3";system("bad")'}, {"assets": []}]:
            with self.subTest(change=change), self.assertRaises(ValueError):
                updater.release_metadata(release() | change)

    def test_invalid_assets(self):
        for change in [{"digest": None}, {"digest": "sha256:bad"}, {"size": 0}, {"browser_download_url": "https://example.com/a.dmg"}]:
            data = release()
            data["assets"][0].update(change)
            with self.subTest(change=change), self.assertRaises(ValueError):
                updater.release_metadata(data)
        data = release()
        data["assets"].append(copy.deepcopy(data["assets"][0]))
        with self.assertRaises(ValueError):
            updater.release_metadata(data)

    def test_render_preserves_cask_and_supports_version_reset(self):
        template = (updater.ROOT / "Casks/kanivet.rb").read_text()
        version, assets = updater.release_metadata(release())
        result = updater.render(template.replace('version "0.1.2"', 'version "0.37.0"'), version, assets)
        self.assertIn('version "0.1.2"', result)
        self.assertIn('app "kanivet.app"', result)
        self.assertIn('auto_updates true', result)
        self.assertEqual(updater.render(result, version, assets), result)
        with self.assertRaises(ValueError):
            updater.render("invalid template", version, assets)

    def test_download_mismatch(self):
        import io
        with patch.object(updater.urllib.request, "urlopen", return_value=io.BytesIO(b"error page")):
            with self.assertRaises(ValueError):
                updater.verify_download(release()["assets"][0])

    def test_update_atomic_validation_and_idempotence(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            template = (updater.ROOT / "Casks/kanivet.rb").read_text()
            paths = [root / "Casks/kanivet.rb", root / "official-cask-submission/kanivet.rb"]
            for path in paths:
                path.parent.mkdir(parents=True)
                path.write_text(template)
            with patch.object(updater, "verify_download", side_effect=[None, ValueError("bad intel")]):
                with self.assertRaises(ValueError):
                    updater.update(release(), root)
            self.assertTrue(all(path.read_text() == template for path in paths))
            with patch.object(updater, "verify_download") as download:
                updater.update(release(), root)
                self.assertEqual(download.call_count, 2)
                download.reset_mock()
                updater.update(release(), root)
                download.assert_not_called()


if __name__ == "__main__":
    unittest.main()
