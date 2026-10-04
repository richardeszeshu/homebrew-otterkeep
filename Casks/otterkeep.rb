cask "otterkeep" do
  version "1.3.1"
  sha256 "3229bf2499bf705d2c0008e8016b2ccec68213e35b40fb5300a2005743d534e0"

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
