local M = {}

function M.open()
  local keymap_path = vim.fn.stdpath("config") .. "/KEYMAP.md"

  if vim.fn.filereadable(keymap_path) == 0 then
    vim.notify("KEYMAP.md not found at " .. keymap_path, vim.log.levels.ERROR)
    return
  end

  -- Window dimensions
  local width  = math.floor(vim.o.columns * 0.80)
  local height = math.floor(vim.o.lines   * 0.80)
  local row    = math.floor((vim.o.lines   - height) / 2)
  local col    = math.floor((vim.o.columns - width)  / 2)

  -- Create a scratch buffer and load the file into it
  local buf = vim.api.nvim_create_buf(false, true)
  local lines = vim.fn.readfile(keymap_path)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].filetype  = "markdown"
  vim.bo[buf].modifiable = false
  vim.bo[buf].readonly   = true
  vim.bo[buf].bufhidden  = "wipe"

  -- Open the float
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width    = width,
    height   = height,
    row      = row,
    col      = col,
    style    = "minimal",
    border   = "rounded",
    title    = "  Keymaps ",
    title_pos = "center",
    footer    = "  q / Esc  close    Ctrl+d/u  scroll  ",
    footer_pos = "center",
  })

  -- Window-local options
  vim.wo[win].wrap         = false
  vim.wo[win].cursorline   = true
  vim.wo[win].conceallevel = 2
  vim.wo[win].concealcursor = "nvic"
  vim.wo[win].winblend     = 0

  -- Close on q or Esc
  for _, key in ipairs({ "q", "<Esc>" }) do
    vim.keymap.set("n", key, function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end, { buffer = buf, silent = true, nowait = true })
  end

  -- Scroll keymaps
  vim.keymap.set("n", "<C-d>", "<C-d>zz", { buffer = buf, silent = true })
  vim.keymap.set("n", "<C-u>", "<C-u>zz", { buffer = buf, silent = true })
end

return M
