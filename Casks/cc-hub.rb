cask "cc-hub" do
  version "0.2.1"
  sha256 "a687de05d5d2dff84a51d25e7dbbd3f69f57f5f3c1c2eb4b6c5ed6719ef4a52c"

  url "https://github.com/yanoryuu/cc-hub-mac/releases/download/mac-v#{version}/CC-Hub-#{version}-arm64.dmg"
  name "CC Hub"
  desc "Hub for running and watching many Claude Code sessions"
  homepage "https://github.com/yanoryuu/cc-hub-mac"

  depends_on arch: :arm64
  depends_on :macos

  app "CC Hub.app"

  # 署名していないので、ダウンロードで付く quarantine を外す(外さないと初回の起動で止められる)。
  # Homebrew 6 の install steps は引数を展開しないので、既定の /Applications を前提にする(--appdir を変えた場合は手で外す)
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "/Applications/CC Hub.app"],
        must_succeed:   false,
        writable_paths: ["CC Hub.app"],
        writable_base:  :appdir
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
