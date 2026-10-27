return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false, -- must be loaded at startup or the default statusline flashes
  config = function()
    -- ─── Dracula palette ─────────────────────────────────────────────────────
    local c = {
      bg      = "#282a36",
      fg      = "#f8f8f2",
      comment = "#6272a4",
      cyan    = "#8be9fd",
      green   = "#50fa7b",
      orange  = "#ffb86c",
      pink    = "#ff79c6",
      purple  = "#bd93f9",
      red     = "#ff5555",
      yellow  = "#f1fa8c",
    }

    local function hl(fg, bg, gui)
      return { fg = fg, bg = bg or "NONE", gui = gui }
    end

    -- Transparent everywhere except the mode block
    local theme = {
      normal   = { a = hl(c.bg, c.purple, "bold"), b = hl(c.fg), c = hl(c.comment) },
      insert   = { a = hl(c.bg, c.green,  "bold"), b = hl(c.fg), c = hl(c.comment) },
      visual   = { a = hl(c.bg, c.pink,   "bold"), b = hl(c.fg), c = hl(c.comment) },
      replace  = { a = hl(c.bg, c.orange, "bold"), b = hl(c.fg), c = hl(c.comment) },
      command  = { a = hl(c.bg, c.yellow, "bold"), b = hl(c.fg), c = hl(c.comment) },
      terminal = { a = hl(c.bg, c.cyan,   "bold"), b = hl(c.fg), c = hl(c.comment) },
      inactive = { a = hl(c.comment), b = hl(c.comment), c = hl(c.comment) },
    }

    local function file_icon()
      local f = vim.api.nvim_buf_get_name(0)
      local icon = require("nvim-web-devicons").get_icon(f, vim.fn.fnamemodify(f, ":e"), { default = true })
      return (icon or "") .. " "
    end

    local normal_buf = function() return vim.bo.buftype == "" end
    local terminal_buf = function() return vim.bo.buftype == "terminal" end

    local winbar_c = {
      { function() return "  TERMINAL" end, color = { fg = c.purple, gui = "bold" }, cond = terminal_buf },
      { function() return " " end, color = { fg = c.green }, cond = normal_buf },
      { function() return " » " end, color = { fg = c.comment }, cond = normal_buf },
      { file_icon, cond = normal_buf },
      { "filename", path = 0, symbols = { modified = " ●", readonly = " " }, cond = normal_buf },
    }

    require("lualine").setup({
      options = {
        theme = theme,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "alpha" },
          winbar = { "lazy", "mason", "noice", "alpha", "neo-tree", "help", "qf" },
        },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          { "branch", icon = "" },
          { "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            colored = true,
            diff_color = {
              added    = { fg = c.green },
              modified = { fg = c.yellow },
              removed  = { fg = c.red },
            } },
        },
        lualine_c = {
          { "diagnostics",
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
            update_in_insert = false },
          { "filename",
            path = 0,
            symbols = { modified = " ●", readonly = " ", newfile = "[No Name]", unnamed = "[No Name]" } },
        },
        lualine_x = { { "filetype", icon_only = false } },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      winbar = {
        lualine_c = winbar_c,
      },
      inactive_winbar = {
        lualine_c = winbar_c,
      },
    })
  end,
}
