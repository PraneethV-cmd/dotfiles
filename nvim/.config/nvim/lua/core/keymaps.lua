local map = vim.keymap.set

-- ─── Keymap reference viewer ─────────────────────────────────────────────────

map("n", "<leader>?", function()
  require("core.keymap-viewer").open()
end, { desc = "Open keymap reference" })

-- ─── Message / error log viewer ──────────────────────────────────────────────

-- <leader>ml — open messages float (all nvim errors/warnings)
map("n", "<leader>ml", function()
  require("core.messages").open()
end, { desc = "Open message log" })

-- <leader>mh — run :checkhealth for a plugin (prompts for name)
map("n", "<leader>mh", function()
  vim.ui.input({ prompt = "checkhealth plugin (blank = all): " }, function(input)
    if input == nil then return end
    require("core.messages").health(input)
  end)
end, { desc = "Run checkhealth" })

-- <leader>mt — treesitter health specifically
map("n", "<leader>mt", function()
  require("core.messages").health("nvim-treesitter")
end, { desc = "Treesitter health check" })

-- ─── Better defaults ──────────────────────────────────────────────────────────

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Keep cursor centered when searching
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Don't lose register when pasting over selection
map("x", "<leader>p", '"_dP', { desc = "Paste without losing register" })

-- Delete to void register
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete to void" })

-- Save
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
map("i", "<C-s>", "<esc><cmd>w<cr>", { desc = "Save file" })

-- Quit
map("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })

-- ─── Window navigation ────────────────────────────────────────────────────────

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- ─── Buffer navigation ────────────────────────────────────────────────────────

map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Close buffer" })

-- ─── Indenting ────────────────────────────────────────────────────────────────

map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- ─── Move lines ───────────────────────────────────────────────────────────────

map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- ─── Clear search highlight ───────────────────────────────────────────────────

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- ─── Diagnostics ─────────────────────────────────────────────────────────────

map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic float" })

-- ─── Splits ───────────────────────────────────────────────────────────────────

map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Equal split sizes" })
map("n", "<leader>sc", "<cmd>close<cr>", { desc = "Close split" })
