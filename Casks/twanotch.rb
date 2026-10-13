cask "twanotch" do
  version "1.1.0"
  sha256 "c2305c44fc054b9d324610b943f8babc211b97acd85fe8058c229fd17d64e591"

  url "https://github.com/twan-nguyen/twanotch/releases/download/v#{version}/TwaNotch-#{version}.zip"
  name "Twanotch"
  desc "Music, calendar, file shelf and HUD hub for the notch"
  homepage "https://github.com/twan-nguyen/twanotch"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "TwaNotch.app"

  # Self-signed and not notarized: clear the download quarantine so Gatekeeper lets it open.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/TwaNotch.app"]
  end

  uninstall quit: "com.twan.twanotch"

  zap trash: [
    "~/Library/Application Scripts/com.twan.twanotch",
    "~/Library/Containers/com.twan.twanotch",
  ]
end
