# Neovim Configuration

## 構成

```
~/.config/nvim/
├── init.lua                    # エントリポイント
└── lua/
    ├── config/
    │   ├── options.lua         # 基本設定
    │   └── keymaps.lua         # キーマッピング
    └── plugins/
        └── init.lua            # プラグイン定義 (lazy.nvim)
```

## プラグイン一覧

| プラグイン | 用途 |
|------------|------|
| lazy.nvim | プラグインマネージャー |
| iceberg.vim | カラースキーム |
| lualine.nvim | ステータスライン |
| telescope.nvim | ファジーファインダー |
| neo-tree.nvim | ファイルエクスプローラー |
| nvim-treesitter | シンタックスハイライト |
| gitsigns.nvim | Git差分表示 |
| vim-fugitive | Git操作 |
| Comment.nvim | コメントトグル |
| nvim-surround | 囲み文字操作 |
| nvim-autopairs | 自動括弧補完 |
| indent-blankline.nvim | インデントガイド |
| flash.nvim | 高速カーソル移動 |
| which-key.nvim | キーバインドヘルプ |

## キーマッピング

Leader key: `Space`

### ファイル操作 (元.vimrc互換)

| キー | 機能 |
|------|------|
| `Space+a` | ファイル検索 (カレントディレクトリ) |
| `Space+f` | バッファ一覧 |
| `Space+d` | 最近開いたファイル |
| `Space+b` | バッファ一覧 |
| `Space+r` | レジスタ |
| `Space+h` | レジスタ (ヤンク履歴) |
| `Space+o` | アウトライン (LSPシンボル) |
| `Space+Enter` | ファイル検索 (再帰) |
| `Space+g` | テキスト検索 (live grep) |
| `Space+e` | ファイルツリー (Neo-tree) |

### Git操作

| キー | 機能 |
|------|------|
| `gs` | Git status |
| `gl` | Git log (commits) |
| `gh` | Git branches |

### 編集操作

| キー | 機能 |
|------|------|
| `gcc` | 行コメントトグル |
| `gc` (Visual) | 選択範囲コメントトグル |
| `s` | Flash (高速移動) |
| `ys{motion}{char}` | 囲み文字追加 |
| `ds{char}` | 囲み文字削除 |
| `cs{old}{new}` | 囲み文字変更 |

### ウィンドウ・バッファ

| キー | 機能 |
|------|------|
| `Ctrl+h/j/k/l` | ウィンドウ移動 |
| `Shift+h` | 前のバッファ |
| `Shift+l` | 次のバッファ |

### その他

| キー | 機能 |
|------|------|
| `Space+w` | 保存 |
| `Space+q` | 終了 |
| `F10` | シンボル一覧 |
| `Esc` | 検索ハイライト解除 |

## 基本設定

- 行番号: 相対行番号有効
- タブ: 2スペース (Go は 4タブ)
- スワップファイル: 無効
- クリップボード: システムクリップボード連携
- マウス: 有効
- 80文字カラム表示

## コマンド

```vim
:Lazy              " プラグイン管理画面
:Lazy sync         " プラグイン更新
:Telescope         " Telescope起動
:Neotree           " ファイルツリー
:TSUpdate          " Treesitter更新
```

## 移行元

元の `~/.vimrc` (unite.vim, lightline等) からの移行設定。
キーマッピングは可能な限り互換性を維持。
