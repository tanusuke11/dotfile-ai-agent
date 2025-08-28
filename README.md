# dotfile-ai-agent

このリポジトリは、複数のプロジェクト間で AI エージェントの設定ファイルを共有するためのものです。

## 含まれるファイル・ディレクトリ

`manifest.json` で管理される同期対象ファイル：

- `.vscode/` - VS Code 設定
- `.claude/` - Claude Code の設定ファイル
- `.gemini/` - Gemini CLI の設定ファイル
- `.codex/` - Codex CLI の設定ファイル
- `.copilotignore` - GitHub Copilot から除外するファイル・ディレクトリ
- `.aiexclude` - Gemini CLI ツールから除外するファイル・ディレクトリ

## 使用方法

### 1. Git Sub Module の 追加

```bash
git submodule add https://github.com/tanusuke11/dotfile-ai-agent .dotfile-ai-agent
git submodule update --init --recursive
```

### 2. 初期設定

1. 各プロジェクトの `.gitignore` に以下を追加してください：

```gitignore
# AI Agent configs (managed by submodule)
.vscode
.claude
.gemini
.codex
.copilotignore
.aiexclude
```

2. スクリプトの設定

> [just](https://github.com/casey/just) でのスクリプト管理例

各プロジェクトのルートディレクトリの `justfile` に以下の import 文を追加

```justfile
import 'scripts/dotfile.just'
```

以下の内容で `scripts/dotfile.just` を作成

```justfile
# AI Agent Configuration Management
# Call scripts from .dotfile-ai-agent/scripts directory

# Pull configuration updates from remote and copy to project root
dotfile-pull:
    chmod +x .dotfile-ai-agent/scripts/pull.sh
    .dotfile-ai-agent/scripts/pull.sh

# Copy project settings to submodule and push changes to remote
dotfile-push:
    chmod +x .dotfile-ai-agent/scripts/push.sh
    .dotfile-ai-agent/scripts/push.sh

# Sync submodules only (local sync, no file copying)
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

### 3. 操作例

```bash
# 最新の設定を取得してプロジェクトルートにコピー
just dotfile-pull

# プロジェクトルートの設定をsubmoduleにコピーしてリモートにプッシュ
just dotfile-push

# submodule間の同期のみ（ファイルコピーなし）
just dotfile-sync

# submodule管理ファイルの追加
just dotfile-add
```

## 動作フロー

### pull.sh

1. submodule の更新 (`git submodule update --init --recursive`)
2. 各 submodule で fetch & merge
3. `manifest.json`に定義されたファイルを`.dotfile-ai-agent/`からプロジェクトルートにコピー

### push.sh

1. `manifest.json`に定義されたファイルをプロジェクトルートから`.dotfile-ai-agent/`にコピー
2. 各 submodule で変更をコミット & プッシュ

### sync.sh

- 各 submodule で fetch & merge のみ（純粋なローカル同期）

## manifest.json

同期対象のファイル・ディレクトリを定義：

```json
{
  "files": [
    ".vscode/**",
    ".claude/**",
    ".gemini/**",
    ".codex/**",
    ".copilotignore",
    ".aiexclude"
  ]
}
```
