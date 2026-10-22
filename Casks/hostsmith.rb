cask "hostsmith" do
  version "2.1.0"
  sha256 "2fc8ea1f1d4cb7af80d44031c563e1c225df5eca972e7014f15e81a9f55163ed"

  url "https://github.com/twan-nguyen/hostsmith/releases/download/v#{version}/HostSmith-#{version}.zip"
  name "HostSmith"
  desc "Switch /etc/hosts environments and see listening ports"
  homepage "https://github.com/twan-nguyen/hostsmith"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "HostSmith.app"

  # Ad-hoc signed and not notarized: clear the download quarantine so Gatekeeper lets it open.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/HostSmith.app"]
  end

  uninstall quit: "com.hostsmith.desktop"

  zap trash: [
    "~/.config/hostsmith",
    "~/.config/hosven",
    "~/Library/Application Support/com.twannguyen.hosven",
    "~/Library/Preferences/com.twannguyen.hosven.plist",
    "~/Library/Application Support/com.hostsmith.desktop",
    "~/Library/Caches/com.hostsmith.desktop",
    "~/Library/Preferences/com.hostsmith.desktop.plist",
    "~/Library/Saved Application State/com.hostsmith.desktop.savedState",
    "~/Library/WebKit/com.hostsmith.desktop",
  ]
end
