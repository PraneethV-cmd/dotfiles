local opt = vim.opt

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.shiftround = true
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "auto"      -- show gutter only when there are git signs/diagnostics
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cmdheight = 0            -- noice owns the cmdline area
opt.laststatus = 3           -- single global statusline
opt.fillchars = {
  eob = " ",                 -- hide ~ at end of buffer
  fold = " ",
  foldsep = " ",
  diff = "╱",
}
opt.list = true              -- show whitespace markers
opt.listchars = {
  tab = "  ",
  trail = "·",
  nbsp = "␣",
}
opt.showmode = false         -- noice handles this
opt.pumheight = 10           -- completion menu max items

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Backspace
opt.backspace = "indent,eol,start"

-- Mouse
opt.mouse = "a"

-- Files
opt.swapfile = false
opt.backup = false
opt.autoread = true          -- auto-reload buffers changed externally (e.g. by Claude Code)
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Folds (using treesitter)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99           -- open all folds by default

-- Diff
opt.diffopt:append("indent-heuristic")  -- 0.12 default, explicit here

-- Borders
opt.winblend = 0             -- keep 0 for transparency to work correctly
opt.pumblend = 0
