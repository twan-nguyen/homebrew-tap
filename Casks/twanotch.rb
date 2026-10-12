cask "twanotch" do
  version "1.0.0"
  sha256 "2df64ccef9b9d97a68fcebce0f8ab440ff04a7ebd58051fdd1d2b46266d37df8"

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
