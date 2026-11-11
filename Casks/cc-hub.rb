cask "cc-hub" do
  version "0.2.0"
  sha256 "1d4bdf8e416161c131ce14684c6365906ee0e5ec69c8f026a26298a03acb6493"

  url "https://github.com/yanoryuu/cc-hub-mac/releases/download/mac-v#{version}/CC-Hub-#{version}-arm64.dmg"
  name "CC Hub"
  desc "Hub for running and watching many Claude Code sessions"
  homepage "https://github.com/yanoryuu/cc-hub-mac"

  depends_on arch: :arm64
  depends_on macos: ">= :big_sur"

  app "CC Hub.app"

  # 署名していないので、ダウンロードで付く quarantine を外す(外さないと初回の起動で止められる)
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/CC Hub.app"]
  end

  # アプリを閉じ、同梱の node で動いているデーモンも止める
  uninstall quit:   "com.yanoryuu.cchub",
            script: {
              executable:   "/usr/bin/pkill",
              args:         ["-f", "CC Hub.app/Contents/Resources/hub/"],
              must_succeed: false,
            }

  zap trash: [
    "~/Library/Application Support/CC Hub",
    "~/Library/Application Support/cc-hub",
    "~/Library/Preferences/com.yanoryuu.cchub.plist",
    "~/Library/Saved Application State/com.yanoryuu.cchub.savedState",
  ]

  caveats <<~EOS
    初回の起動で Claude Code との連携(mod・MCP・スキル)を設定します。
    連携を外すときは、アンインストールの前にアプリ内の手順か README を参照してください。
  EOS
end
