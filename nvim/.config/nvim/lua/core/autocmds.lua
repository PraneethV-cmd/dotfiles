local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ─── Reload buffers changed on disk (external edits / agent) ──────────────────

autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = augroup("checktime_reload", { clear = true }),
  pattern = "*",
  command = "checktime",
})

-- ─── Highlight on yank ────────────────────────────────────────────────────────

autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.hl.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})

-- ─── Remove trailing whitespace on save ──────────────────────────────────────

autocmd("BufWritePre", {
  group = augroup("trim_whitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- ─── Resize splits on window resize ─────────────────────────────────────────

autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- ─── Go to last location on file open ────────────────────────────────────────

autocmd("BufReadPost", {
  group = augroup("last_location", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ─── Close certain filetypes with just q ─────────────────────────────────────

autocmd("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = { "help", "lspinfo", "man", "notify", "qf", "startuptime", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- ─── Auto-create directories on save ─────────────────────────────────────────

autocmd("BufWritePre", {
  group = augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- ─── Hide whitespace markers in dashboards / special UI buffers ──────────────

autocmd("FileType", {
  group = augroup("no_listchars", { clear = true }),
  pattern = {
    "alpha", "dashboard", "lazy", "mason", "noice", "help",
    "trouble", "TelescopePrompt", "lspinfo", "checkhealth",
    "neo-tree",
  },
  callback = function() vim.opt_local.list = false end,
})

-- ─── 4-space indent everywhere (filetype plugins like yaml force 2) ──────────
-- A project's .editorconfig still wins.

autocmd("FileType", {
  group = augroup("indent_4", { clear = true }),
  callback = function(event)
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(event.buf) or next(vim.b[event.buf].editorconfig or {}) then return end
      vim.bo[event.buf].shiftwidth = 4
      vim.bo[event.buf].tabstop = 4
      vim.bo[event.buf].softtabstop = 4
      vim.bo[event.buf].expandtab = true
    end)
  end,
})
