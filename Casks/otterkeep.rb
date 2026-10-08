cask "otterkeep" do
  version "1.6.0"
  sha256 "ad85cde1286c56e964b0387f4864a54c3b367143d157305007844d2cb25e990a"

  url "https://github.com/richardeszeshu/otter-keep/releases/download/v#{version}/OtterKeep-#{version}.zip"
  name "OtterKeep"
  desc "Autonomous, APFS-native incremental backup & replication engine"
  homepage "https://github.com/richardeszeshu/otter-keep"

  livecheck do
    url "https://raw.githubusercontent.com/richardeszeshu/otter-keep/main/Distribution/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: :sequoia

  app "OtterKeep.app"
  binary "#{appdir}/OtterKeep.app/Contents/MacOS/otterkeep"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-rd", "com.apple.quarantine", "{{appdir}}/OtterKeep.app"],
        must_succeed: false
  end

  zap trash: [
    "~/.otterkeep",
    "~/Library/Application Support/OtterKeep",
    "~/Library/Caches/com.otterkeep.app",
    "~/Library/HTTPStorages/com.otterkeep.app",
    "~/Library/Logs/OtterKeep",
    "~/Library/Preferences/com.otterkeep.app.plist",
    "~/Library/Saved Application State/com.otterkeep.app.savedState",
  ]
end
