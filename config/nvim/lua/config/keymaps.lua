local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ESCでハイライト解除
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- ウィンドウ移動
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- バッファ移動
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)

-- インデント時に選択を維持
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- 行移動
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- ============================================
-- 元の.vimrc互換キーマップ (Unite -> Telescope)
-- ============================================

-- Space+a: カレントディレクトリのファイル
keymap("n", "<leader>a", "<cmd>Telescope find_files<CR>", { desc = "Files in current dir" })

-- Space+f: バッファ + 最近のファイル
keymap("n", "<leader>f", "<cmd>Telescope buffers<CR>", { desc = "Buffers + Recent" })

-- Space+d: 最近のディレクトリ (Telescopeでは直接対応なし、find_filesで代用)
keymap("n", "<leader>d", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

-- Space+b: バッファ一覧
keymap("n", "<leader>b", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })

-- Space+r: レジスタ
keymap("n", "<leader>r", "<cmd>Telescope registers<CR>", { desc = "Registers" })

-- Space+t: タブ (Neovimではバッファベースが主流なのでbuffersで代用)
keymap("n", "<leader>t", "<cmd>Telescope buffers<CR>", { desc = "Tabs/Buffers" })

-- Space+h: ヤンク履歴 (Telescopeのregistersで代用)
keymap("n", "<leader>h", "<cmd>Telescope registers<CR>", { desc = "Yank history" })

-- Space+o: アウトライン (LSPシンボル)
keymap("n", "<leader>o", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Outline" })

-- Space+Enter: ファイル検索 (再帰)
keymap("n", "<leader><CR>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

-- ============================================
-- Git (元の.vimrc互換: gs, gl, gh)
-- ============================================
keymap("n", "gs", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
keymap("n", "gl", "<cmd>Telescope git_commits<CR>", { desc = "Git log" })
keymap("n", "gh", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })

-- ============================================
-- 追加の便利キーマップ
-- ============================================

-- ファイルエクスプローラー
keymap("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })

-- 保存・終了
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Live grep (新規追加、便利なので)
keymap("n", "<leader>g", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })

-- Tagbar代替 (F10)
keymap("n", "<F10>", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Symbols" })
