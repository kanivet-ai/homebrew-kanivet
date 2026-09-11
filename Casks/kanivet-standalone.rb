cask "kanivet-standalone" do
  version "0.1.0"
  sha256 :no_check

  url "https://github.com/kanivet-ai/kanivet-oss/releases"
  name "Kanivet Standalone (legacy)"
  desc "Legacy package; reinstall the open-source kanivet cask instead"
  homepage "https://kanivet.io/"

  disable! date: "2026-09-11", because: :discontinued, replacement_cask: "kanivet"

  app "kanivet-standalone.app"
end
