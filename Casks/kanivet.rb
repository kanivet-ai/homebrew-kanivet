cask "kanivet" do
  arch arm: "arm64", intel: "x64"

  version "0.9.1"
  sha256 arm:   "a4c84bc52f9c028deef2612911eb824c70e2f3a528e383c909623744843352c9",
         intel: "6eee51d80ff55f41497cb4bf1236a26641a888d1d6238436ea2e8a73d385d19c"

  url "https://kanivet-releases.s3.eu-west-1.amazonaws.com/kanivet-#{version}-#{arch}-mac.dmg"
  name "Kanivet"
  desc "Kubernetes cluster navigation and troubleshooting"
  homepage "https://kanivet.io/"

  livecheck do
    url "https://kanivet-releases.s3.eu-west-1.amazonaws.com/latest-mac.yml"
    strategy :electron_builder
  end

  auto_updates true
  depends_on macos: ">= :monterey"

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
