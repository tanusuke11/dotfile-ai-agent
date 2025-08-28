# dotfile-ai-agent

このリポジトリは、複数のプロジェクト間で AI エージェントの設定ファイルを共有するためのものです。

## 含まれるファイル・ディレクトリ

- `.claude/` - Claude Code の設定ファイル
- `.gemini/` - Gemini CLI の設定ファイル
- `.github/` - GitHub 関連の設定
- `.vscode/` - VS Code 設定
- `.aiexclude` - Gemini CLI から除外するファイル・ディレクトリ
- `.copilotignore` - GitHub Copilot から除外するファイル・ディレクトリ

## 使用方法

> [just](https://github.com/casey/just) でのスクリプト管理例

### 1. justfile の設定

各プロジェクトのルートディレクトリの `justfile` に以下の import 文を追加

```justfile
import 'scripts/dotfile.just'
```

以下の内容で `scripts/dotfile.just` を作成

```justfile
# AI Agent Configuration Management
# Call scripts from .dotfile-ai-agent/scripts directory

# Pull configuration updates
dotfile-pull:
    chmod +x .dotfile-ai-agent/scripts/pull.sh
    .dotfile-ai-agent/scripts/pull.sh

# Push configuration changes
dotfile-push message="Update AIs agent configuration":
    chmod +x .dotfile-ai-agent/scripts/push.sh
    .dotfile-ai-agent/scripts/push.sh "{{message}}"

# Sync configuration with conflict resolution
dotfile-sync:
    chmod +x .dotfile-ai-agent/scripts/sync.sh
    .dotfile-ai-agent/scripts/sync.sh

# Add file to manifest
dotfile-add path:
    chmod +x .dotfile-ai-agent/scripts/add.sh
    .dotfile-ai-agent/scripts/add.sh "{{path}}"

# Install dependencies
dotfile-dependency:
    chmod +x .dotfile-ai-agent/scripts/dependency.sh
    .dotfile-ai-agent/scripts/dependency.sh
```

### 2. 初回設定

1. 各プロジェクトの `.gitignore` に以下を追加してください：

```gitignore
# AI Agent configs (managed by submodule)
.dotfile-ai-agent
.claude
.gemini
.github
.vscode
.aiexclude
.copilotignore
```

2．プロジェクトディレクトリで以下を実行

```bash
just dotfile-init
```

### 3. 操作例

```bash
# 最新の設定を取得
just dotfile-pull

# 設定ファイルを編集後、変更をプッシュ
just dotfile-push "Update Claude model settings"

# 状態確認
just dotfile-status

# 差分確認
just dotfile-diff
```

## カスタマイズ

### 設定ファイルの追加・削除

管理対象ファイルを変更したい場合は、`config_files` 変数を編集してください：

```justfile
# 管理対象ファイル・ディレクトリ（スペース区切り）
config_files := ".claude .gemini .github .vscode .aiexclude .copilotignore .my-custom-config"
```

## トラブルシューティング

### シンボリックリンクが作成されない場合

```bash
just _create-symlinks
```

### 設定をリセットしたい場合

```bash
just dotfile-reset
```

### 完全にクリーンアップしたい場合

```bash
just dotfile-clean
```
