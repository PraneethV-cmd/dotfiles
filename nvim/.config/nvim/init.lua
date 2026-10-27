require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins" },              -- lua/plugins/*.lua (which-key)
  { import = "plugins.ui" },           -- lua/plugins/ui/*.lua
  { import = "plugins.lsp" },          -- lua/plugins/lsp/*.lua
  { import = "plugins.completion" },   -- lua/plugins/completion/*.lua
  { import = "plugins.editor" },       -- lua/plugins/editor/*.lua
  { import = "plugins.git" },          -- lua/plugins/git/*.lua
  { import = "plugins.tools" },        -- lua/plugins/tools/*.lua
}, {
  change_detection = { notify = false },
  ui = { border = "rounded" },
})
