cask "kanivet-standalone" do
  # TODO: add arm64 builds when available
  # arch arm: "arm64", intel: "x64"

  version "0.1.0"
  sha256 :no_check

  url "file:///dev/null"
  name "Kanivet Standalone"
  desc "Kubernetes IDE - standalone version (no account required)"
  homepage "https://kanivet.io"

  # x64 binary runs on Apple Silicon via Rosetta (no native arm64 build yet)

  preflight do
    require "json"
    require "net/http"
    require "uri"

    harbor = "harbor.cluster.nmworks.xyz"
    repo = "kanivet/standalone"
    tag = "v#{version}-x64"

    # Get anonymous pull token
    token_uri = URI("https://#{harbor}/service/token?service=harbor-registry&scope=repository:#{repo}:pull")
    token_resp = Net::HTTP.get(token_uri)
    token = JSON.parse(token_resp)["token"]

    # Fetch manifest to get blob digest
    manifest_uri = URI("https://#{harbor}/v2/#{repo}/manifests/#{tag}")
    manifest_req = Net::HTTP::Get.new(manifest_uri)
    manifest_req["Authorization"] = "Bearer #{token}"
    manifest_req["Accept"] = "application/vnd.oci.image.manifest.v1+json"

    manifest_resp = Net::HTTP.start(manifest_uri.host, manifest_uri.port, use_ssl: true) do |http|
      http.request(manifest_req)
    end
    manifest = JSON.parse(manifest_resp.body)

    layer = manifest["layers"].first
    digest = layer["digest"]
    filename = layer.dig("annotations", "org.opencontainers.image.title") || "Kanivet-standalone-#{version}-#{arch}.dmg"

    # Download blob
    blob_uri = URI("https://#{harbor}/v2/#{repo}/blobs/#{digest}")
    dmg_path = staged_path / filename

    system_command "/usr/bin/curl",
      args: [
        "-fSL",
        "-H", "Authorization: Bearer #{token}",
        "-o", dmg_path.to_s,
        blob_uri.to_s
      ],
      print_stderr: true
  end

  installer manual: "Kanivet-standalone-#{version}-x64.dmg"

  uninstall quit: "com.kanivet.app"

  zap trash: [
    "~/Library/Application Support/kanivet",
    "~/Library/Preferences/com.kanivet.app.plist",
    "~/Library/Caches/com.kanivet.app",
  ]
end
