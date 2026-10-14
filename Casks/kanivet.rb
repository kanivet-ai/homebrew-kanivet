cask "kanivet" do
  arch arm: "arm64", intel: "x64"

  version "0.6.1"
  sha256 arm:   "b55b70a153450e65e154c01c015d8b8ef2f20026a7a6bd8f63262db91c51d38d",
         intel: "c29c5decc4d5edd836036807a39ffd0f039d6da3d2035ecf9731fb19f6ff7145"

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
