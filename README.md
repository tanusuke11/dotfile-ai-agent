# dotfile-ai-agent

このリポジトリは、複数のプロジェクト間でAIエージェントの設定ファイルを共有するためのものです。

## 含まれるファイル・ディレクトリ

- `.claude/` - Claude Code の設定ファイル
- `.gemini/` - Gemini CLI の設定ファイル
- `.github/` - GitHub関連の設定
- `.vscode/` - VS Code設定
- `.aiexclude` - Gemini CLIから除外するファイル・ディレクトリ
- `.copilotignore` - GitHub Copilotから除外するファイル・ディレクトリ

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
# 共有ディレクトリとシンボリックリンクを使用して設定ファイルを管理

# 変数定義
config_repo := "https://github.com/tanusuke11/dotfile-ai-agent.git"
config_prefix := "/path/to/your/.dotfile-ai-agent"
config_remote := "dotfile-origin"

# 管理対象ファイル・ディレクトリ
config_files := ".claude .gemini .github .vscode .aiexclude .copilotignore"

# 初回セットアップ（共有ディレクトリのクローン）
dotfile-init:
    #!/usr/bin/env bash
    echo "Setting up AI agent configuration..."
    mkdir -p "$(dirname {{config_prefix}})"
    if [ ! -d "{{config_prefix}}" ]; then
        echo "Cloning configuration repository..."
        git clone {{config_repo}} {{config_prefix}}
    else
        echo "Configuration directory already exists, pulling latest changes..."
        cd {{config_prefix}} && git pull origin main
    fi
    echo "Creating symbolic links..."
    just _create-symlinks
    echo "Setup complete!"

# 設定ファイルの最新版を取得
dotfile-pull:
    #!/usr/bin/env bash
    echo "Pulling latest AI agent configuration..."
    cd {{config_prefix}} && git pull origin main
    echo "Configuration updated!"

# 設定ファイルの変更をプッシュ
dotfile-push message="Update AI agent configuration":
    #!/usr/bin/env bash
    echo "Pushing AI agent configuration changes..."
    cd {{config_prefix}} && git add -A
    cd {{config_prefix}} && git commit -m "{{message}}" || echo "No changes to commit"
    cd {{config_prefix}} && git push origin main
    echo "Configuration pushed!"

# 設定ファイルの状態確認
dotfile-status:
    #!/usr/bin/env bash
    echo "AI Agent configuration status:"
    echo "================================"
    cd {{config_prefix}} && git status
    echo ""
    echo "Symlinks status:"
    for file in {{config_files}}; do
        if [ -L "$file" ]; then
            echo "  $file -> $(readlink "$file")"
        fi
    done

# 設定ファイルの差分確認
dotfile-diff:
    #!/usr/bin/env bash
    echo "AI Agent configuration differences:"
    echo "==================================="
    cd {{config_prefix}} && git diff

# 設定ファイルのリセット（注意：変更が失われます）
dotfile-reset:
    #!/usr/bin/env bash
    echo "Resetting AI agent configuration..."
    echo "WARNING: This will discard all local changes!"
    read -p "Are you sure? (y/N): " confirm && [ "$confirm" = "y" ] || exit 1
    cd {{config_prefix}} && git reset --hard HEAD && git clean -fd
    echo "Configuration reset complete!"

# シンボリックリンクの作成（内部使用）
_create-symlinks:
    #!/usr/bin/env bash
    echo "Creating symbolic links..."
    for file in {{config_files}}; do
        if [ -e "{{config_prefix}}/$file" ]; then
            ln -sf "{{config_prefix}}/$file" "$file" 2>/dev/null || true
            echo "  Created symlink: $file -> {{config_prefix}}/$file"
        fi
    done
    echo "Symbolic links created!"

# シンボリックリンクの削除
dotfile-clean:
    #!/usr/bin/env bash
    echo "Removing symbolic links..."
    for file in {{config_files}}; do
        if [ -L "$file" ]; then
            rm -f "$file"
            echo "  Removed symlink: $file"
        fi
        if [ -e "$file" ]; then
            rm -rf "$file"
            echo "  Removed file: $file"
        fi
    done
    echo "Symbolic links removed!"

```

### 2. 初回セットアップ

1．`dotfile.just` 内でローカルのクローン先を指定

```justfile
config_prefix := "/your/custom/path/.dotfile-ai-agent"
```

2. .gitignore の設定

各プロジェクトの `.gitignore` に以下を追加してください：

```gitignore
# AI Agent config symlinks (managed by shared directory)
.claude
.gemini  
.github
.vscode
.aiexclude
.copilotignore
```

**注意点:**
- シンボリックリンクは各プロジェクトの `.gitignore` で除外する必要があります
- 実際の設定ファイルはローカルのクローン先（`/path/to/your/.dotfile-ai-agent`）で管理されます

3．プロジェクトディレクトリで以下を実行

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