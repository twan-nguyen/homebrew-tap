cask "twan-clean" do
  version "0.1.1"
  sha256 "d1fc047fd820a244880998cefaf762ca71a0353c95619ad7e7e5edac4fe85276"

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
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/TwanClean.app"]
  end

  # Homebrew runs launchctl on upgrade too, which unloads the scheduler;
  # Twan Clean registers it again the next time it opens.
  uninstall launchctl: "com.twan.twanclean.scheduler",
            quit:      "com.twan.twanclean"

  # Only zap removes the login item: on upgrade it would also drop the
  # user's choice to open Twan Clean at login.
  zap login_item: "Twan Clean",
      trash:      [
        "~/Library/Application Support/TwanClean",
        "~/Library/Caches/com.twan.twanclean",
        "~/Library/HTTPStorages/com.twan.twanclean",
        "~/Library/Preferences/com.twan.twanclean.plist",
        "~/Library/Saved Application State/com.twan.twanclean.savedState",
      ]
end
