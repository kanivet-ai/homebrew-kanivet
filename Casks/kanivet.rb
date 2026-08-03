cask "kanivet" do
  arch arm: "arm64", intel: "x64"

  version "0.33.6"
  sha256 arm:   "85f488736049707313949e268a6838fea31660e57934f9366d27483f27bc40a0",
         intel: "093e8b6e88f5ce5ea7b9ab334af670cdcb3564ea08b7e07de9568261c283201e"

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
