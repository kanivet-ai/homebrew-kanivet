cask "kanivet" do
  arch arm: "arm64", intel: "x64"

  version "0.32.0"
  sha256 arm:   "e60f238f5f63a8ad09de680533726f809740a86e795b86176f1198fe8a958e0c",
         intel: "e9b903c69e9de819d8d087961119b7217ef44d94233268f2b47cd00611140566"

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
