cask "clustersmith" do
  version "0.1.0"
  sha256 "484a747c17057a5979edd30f0df4c3f6be6361fc6eba0b6f2aad73aed6583685"

  url "https://github.com/twan-nguyen/clustersmith/releases/download/v#{version}/ClusterSmith-#{version}.zip"
  name "ClusterSmith"
  desc "Desktop client for Kubernetes clusters"
  homepage "https://github.com/twan-nguyen/clustersmith"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "ClusterSmith.app"

  # Ad-hoc signed and not notarized: clear the download quarantine so Gatekeeper lets it open.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/ClusterSmith.app"]
  end

  uninstall quit: "com.clustersmith.desktop"

  zap trash: [
    "~/Library/Application Support/com.clustersmith.desktop",
    "~/Library/Caches/com.clustersmith.desktop",
    "~/Library/Saved Application State/com.clustersmith.desktop.savedState",
    "~/Library/WebKit/com.clustersmith.desktop",
  ]
end
