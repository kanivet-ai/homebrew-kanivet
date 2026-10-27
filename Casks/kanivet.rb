cask "kanivet" do
  arch arm: "arm64", intel: "x64"

  version "0.7.0"
  sha256 arm:   "2ec4a2085615d1f0598770c36c3df801fb0632bab4843a070120463eb33aee6f",
         intel: "88ec7c2be6716240c47e02aca57ccc203edb662b9ac7f813e422180531378535"

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
