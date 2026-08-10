cask "kanivet" do
  arch arm: "arm64", intel: "x64"

  version "0.35.5"
  sha256 arm:   "3518f2e6551b680683076228e161e9ba34a646bf1c645ac09852f9fbd27e24cd",
         intel: "35e0169ebd8d6c39a2f0025c8786307a8d5c5fa5e4015b48aab2b9277e6348b8"

  url "https://releases.kanivet.io/kanivet-standalone-#{version}-#{arch}-mac.dmg"
  name "Kanivet"
  desc "Kubernetes cluster navigation and troubleshooting"
  homepage "https://kanivet.io"

  livecheck do
    url "https://releases.kanivet.io/latest-mac.yml"
    strategy :electron_builder
  end

  auto_updates true
  depends_on macos: ">= :monterey"

  app "kanivet-standalone.app"

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
