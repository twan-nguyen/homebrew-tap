cask "twanotch" do
  version "1.0.4"
  sha256 "5606f834d51105807cd8113dab8682056e7eaa48776c2bed1eb2b109ee7a37ad"

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
