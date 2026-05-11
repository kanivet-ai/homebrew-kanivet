cask "kanivet" do
  arch arm: "arm64", intel: "x64"

  version "0.28.4"
  sha256 arm:   "d36250af7b775afdfba6b445a7d87a2fea7dbff3e6b437f130afdcc31622cdd6",
         intel: "a47f14f84c40a1972e6cb16eba50e940fb8d31c83b2d337c14b3e58927bf9fa4"

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
