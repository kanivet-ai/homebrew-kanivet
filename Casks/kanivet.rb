cask "kanivet" do
  arch arm: "arm64", intel: "x64"

  version "0.1.2"
  sha256 arm:   "29cbabd108e34edd420859afbfd1e52acee72065e99cf29d9290c8a8475ae1b4",
         intel: "d64a69f193acb66d31162c5090f6807e007e86fba65b34472b67c9e703a2a3bc"

  url "https://github.com/kanivet-ai/kanivet-oss/releases/download/v#{version}/kanivet-#{version}-#{arch}-mac.dmg"
  name "Kanivet"
  desc "Kubernetes cluster navigation and troubleshooting"
  homepage "https://kanivet.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  conflicts_with cask: "kanivet-standalone"
  depends_on macos: :monterey

  app "kanivet.app"

  zap trash: [
    "~/Library/Application Support/kanivet",
    "~/Library/Caches/com.kanivet.app",
    "~/Library/Caches/com.kanivet.app.ShipIt",
    "~/Library/HTTPStorages/com.kanivet.app",
    "~/Library/Logs/kanivet",
    "~/Library/Preferences/com.kanivet.app.plist",
    "~/Library/Saved Application State/com.kanivet.app.savedState",
  ]
end
