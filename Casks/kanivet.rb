cask "kanivet" do
  arch arm: "arm64", intel: "x64"

  version "0.29.15"
  sha256 arm:   "caf0f55aed96758a3f773173a672686be2346048c9a1e58046055fbbdc79a1e0",
         intel: "b9b67650ac7e28698bc7127b44e44a8bb9395652046c79c53174adeaa63ee4ae"

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
