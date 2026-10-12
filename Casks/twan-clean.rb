cask "twan-clean" do
  version "0.1.0"
  sha256 "ca6c71a0d8aedec558dbf8b30b61085623dafc14ff92a1fb120b89d8e799bdcd"

  url "https://github.com/twan-nguyen/twan-clean/releases/download/v#{version}/TwanClean-#{version}.zip"
  name "Twan Clean"
  desc "Cleaner, disk map and app uninstaller"
  homepage "https://github.com/twan-nguyen/twan-clean"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "TwanClean.app"

  # Self-signed and not notarized: clear the download quarantine so Gatekeeper lets it open.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/TwanClean.app"]
  end

  uninstall quit:      "com.twan.twanclean",
            launchctl: "com.twan.twanclean.scheduler"

  zap trash: [
    "~/Library/Application Support/TwanClean",
    "~/Library/Caches/com.twan.twanclean",
    "~/Library/HTTPStorages/com.twan.twanclean",
    "~/Library/Preferences/com.twan.twanclean.plist",
    "~/Library/Saved Application State/com.twan.twanclean.savedState",
  ]
end
