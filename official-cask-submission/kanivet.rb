cask "kanivet" do
  arch arm: "arm64", intel: "x64"

  version "0.6.0"
  sha256 arm:   "ec835e5115ffca06438d403c272ff7a7e4392712c249da8b95e6a0b7b299f001",
         intel: "c7146557912790380ce561a517078af8bd7da31ff3f0e43ef7b6b9a42c349ff5"

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
