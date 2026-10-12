cask "twanotch" do
  version "1.0.3"
  sha256 "ca082c21f940cf77136dae64fa5832f6b76e90c6ca703c394237fe776754b45f"

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
