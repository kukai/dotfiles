-- 基本設定
local opt = vim.opt

-- 行番号
opt.number = true
opt.relativenumber = true

-- タブ・インデント
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- 検索
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- 見た目
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.colorcolumn = "80"

-- ファイル
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- クリップボード
opt.clipboard = "unnamedplus"

-- マウス
opt.mouse = "a"

-- 不可視文字表示
opt.list = true
opt.listchars = { tab = ">-", trail = "." }

-- スプリット
opt.splitright = true
opt.splitbelow = true

-- 自動コメント挿入を無効化
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

-- ファイルタイプ別設定
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "ruby" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})
