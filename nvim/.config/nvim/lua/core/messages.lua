local M = {}

-- Opens :messages output in a scrollable float
function M.open()
  local lines = {}

  -- Capture :messages output
  local raw = vim.api.nvim_exec2("messages", { output = true }).output
  if raw == "" then
    lines = { "  No messages." }
  else
    for line in raw:gmatch("[^\n]+") do
      table.insert(lines, line)
    end
  end

  local width  = math.floor(vim.o.columns * 0.85)
  local height = math.floor(vim.o.lines   * 0.75)
  local row    = math.floor((vim.o.lines   - height) / 2)
  local col    = math.floor((vim.o.columns - width)  / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden  = "wipe"
  vim.bo[buf].filetype   = "log"

  local win = vim.api.nvim_open_win(buf, true, {
    relative  = "editor",
    width     = width,
    height    = height,
    row       = row,
    col       = col,
    style     = "minimal",
    border    = "rounded",
    title     = "  Messages / Error Log ",
    title_pos = "center",
    footer    = "  q / Esc  close    G  jump to latest  ",
    footer_pos = "center",
  })

  vim.wo[win].wrap       = true
  vim.wo[win].cursorline = true
  vim.wo[win].winblend   = 0

  -- Jump to bottom so latest errors are visible first
  vim.api.nvim_win_set_cursor(win, { #lines, 0 })

  local function close()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  for _, key in ipairs({ "q", "<Esc>" }) do
    vim.keymap.set("n", key, close, { buffer = buf, silent = true, nowait = true })
  end

  -- Clear messages then close
  vim.keymap.set("n", "dc", function()
    close()
    vim.cmd("messages clear")
    vim.notify("Messages cleared", vim.log.levels.INFO)
  end, { buffer = buf, silent = true, desc = "Clear messages" })

  vim.keymap.set("n", "<C-d>", "<C-d>",  { buffer = buf, silent = true })
  vim.keymap.set("n", "<C-u>", "<C-u>",  { buffer = buf, silent = true })
end

-- Opens :checkhealth for a specific plugin in a split
function M.health(plugin)
  vim.cmd("checkhealth " .. (plugin or ""))
end

return M
