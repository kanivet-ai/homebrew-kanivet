cask "kanivet" do
  arch arm: "arm64", intel: "x64"

  version "0.5.0"
  sha256 arm:   "dcfff5cf8c161d7dcb102b408e776dfb59223650de7c88b72256f361cf5250cb",
         intel: "2c74d00272a374f890411b75c8d0768195fbe9d623ff25fff8d2c88f7ff6cd90"

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
