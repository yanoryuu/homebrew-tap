# yanoryuu/homebrew-tap

yanoryuu の Homebrew tap です。

## CC Hub for Mac

複数の Claude Code セッションを 1 つの画面でまとめて扱うアプリです(Apple Silicon の Mac 用)。
詳しくは [yanoryuu/cc-hub-mac](https://github.com/yanoryuu/cc-hub-mac) を見てください。

```
brew tap yanoryuu/tap
brew trust yanoryuu/tap   # Homebrew 6 以降: 公式以外の tap は一度だけ信頼の登録が要る
brew install --cask yanoryuu/tap/cc-hub
```

- 更新: `brew upgrade --cask cc-hub`
- 削除: `brew uninstall --cask cc-hub`(設定やデータごと消すなら `--zap`)

先に [Claude Code](https://docs.claude.com/en/docs/claude-code/setup) と Git を入れておいてください。
初回の起動で、Claude Code との連携(mod・MCP・スキル)を自動で設定します。
アプリには署名していませんが、Homebrew で入れた場合はそのまま起動できます。
