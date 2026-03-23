cask "kanivet-standalone" do
  version "0.1.0"
  sha256 :no_check

  url "file:///dev/null"
  name "Kanivet Standalone"
  desc "Kubernetes IDE - standalone version (no account required)"
  homepage "https://kanivet.io"

  depends_on formula: "oras"

  preflight do
    system_command "oras",
      args: [
        "pull",
        "harbor.cluster.nmworks.xyz/kanivet/standalone:v#{version}-x64",
        "-o", staged_path.to_s
      ]
  end

  installer manual: "Kanivet-standalone-#{version}-x64.dmg"

  uninstall quit: "com.kanivet.app"

  zap trash: [
    "~/Library/Application Support/kanivet",
    "~/Library/Preferences/com.kanivet.app.plist",
    "~/Library/Caches/com.kanivet.app",
  ]
end
