# Homebrew Tap for Kanivet

Official Homebrew tap for [Kanivet](https://kanivet.io), an open-source Kubernetes IDE.
Packages come from [kanivet-ai/kanivet-oss GitHub releases](https://github.com/kanivet-ai/kanivet-oss/releases), not the retired closed-source release server.

## Installation

```bash
brew install --cask kanivet-ai/kanivet/kanivet
```

Requires macOS Monterey (12.0) or later, on Apple Silicon or Intel.

## Migrate from the closed-source version

OSS versions restarted at `0.1.x`, below the old `0.37.x` versions. A normal upgrade may therefore skip the migration. Quit Kanivet, then run this once:

```bash
brew update
brew reinstall --cask kanivet-ai/kanivet/kanivet
```

If you installed the separate legacy `kanivet-standalone` cask instead:

```bash
brew uninstall --cask kanivet-standalone
brew install --cask kanivet-ai/kanivet/kanivet
```

Do not use `--zap` during migration: application data should be retained. The OSS app is `kanivet.app`, replacing `kanivet-standalone.app`. The old standalone cask is disabled and points to the replacement.

## Updates

The tap checks the latest stable OSS GitHub release every hour (GitHub Actions schedules can be delayed). It supports manual workflow dispatch and the existing `new-release` repository dispatch too. No cross-repository token is needed.

The updater rejects drafts, prereleases, incomplete releases, unexpected URLs, and missing checksums. Before committing a changed release, it downloads both macOS DMGs and verifies their sizes and SHA256 digests against GitHub's asset metadata. Unchanged releases are a no-op. Both the tap cask and the official-submission copy stay in sync.

Kanivet's OSS releases include the app's GitHub auto-updater; `auto_updates true` tells Homebrew about it but does not itself schedule upgrades on your Mac. To explicitly update through Homebrew:

```bash
brew update
brew upgrade --cask --greedy kanivet-ai/kanivet/kanivet
```

## Uninstall

```bash
brew uninstall --cask kanivet
```

To also delete application data, use `brew uninstall --cask --zap kanivet`.

## Development

```bash
python3 -m unittest discover -s tests -v
python3 scripts/update_cask.py
```

Pull requests run updater tests and Homebrew cask validation on macOS.

## License

Kanivet OSS is licensed under [Apache-2.0](https://github.com/kanivet-ai/kanivet-oss/blob/main/LICENSE); see upstream licensing notices for dependencies. No paid Kanivet license is required.
