cask "twanotch" do
  version "1.0.2"
  sha256 "9378c25b8547d31956b9f3c81d3e0974db3f592e5b0829cdcbf6a3bcd94071bc"

  url "https://github.com/twan-nguyen/twanotch/releases/download/v#{version}/TwaNotch-#{version}.zip"
  name "TwaNotch"
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
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/TwaNotch.app"]
  end

  uninstall quit: "com.twan.twanotch"

  zap trash: [
    "~/Library/Application Scripts/com.twan.twanotch",
    "~/Library/Containers/com.twan.twanotch",
  ]
end
