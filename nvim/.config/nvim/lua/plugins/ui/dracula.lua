return {
  "Mofiqul/dracula.nvim",
  priority = 1000, -- load before everything else
  lazy = false,
  config = function()
    vim.o.background = "dark"
    require("dracula").setup({
      transparent_bg = true, -- bg NONE -> terminal (black) shows through
      italic_comment = false,
      show_end_of_buffer = false,
      overrides = function(c)
        return {
          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE" },

          -- blink.cmp: dracula paints every label/kind cell with the opaque
          -- `menu` bg, which shows up as solid rows. Make them transparent.
          Pmenu = { fg = c.fg, bg = "NONE" },
          BlinkCmpMenu = { fg = c.fg, bg = "NONE" },
          BlinkCmpMenuBorder = { fg = c.purple, bg = "NONE" },
          BlinkCmpMenuSelection = { bg = c.selection, bold = true },
          BlinkCmpLabel = { fg = c.fg, bg = "NONE" },
          BlinkCmpLabelDeprecated = { fg = c.comment, bg = "NONE", strikethrough = true },
          BlinkCmpLabelMatch = { fg = c.pink, bg = "NONE", bold = true },
          BlinkCmpLabelDetail = { fg = c.comment, bg = "NONE" },
          BlinkCmpLabelDescription = { fg = c.comment, bg = "NONE" },
          BlinkCmpKind = { fg = c.purple, bg = "NONE" },
          BlinkCmpSource = { fg = c.comment, bg = "NONE" },
          BlinkCmpScrollBarGutter = { bg = "NONE" },
          BlinkCmpScrollBarThumb = { bg = c.comment },
          BlinkCmpGhostText = { fg = c.comment },
          BlinkCmpDoc = { bg = "NONE" },
          BlinkCmpDocBorder = { fg = c.purple, bg = "NONE" },
          BlinkCmpSignatureHelp = { bg = "NONE" },
          BlinkCmpSignatureHelpBorder = { fg = c.purple, bg = "NONE" },
          BlinkCmpSignatureHelpActiveParameter = { fg = c.orange, bold = true },

          -- nvim falls back to these as the base bg of the statusline/winbar,
          -- which would make lualine's transparent sections opaque
          StatusLine = { bg = "NONE" },
          StatusLineNC = { bg = "NONE" },
          WinBar = { bg = "NONE" },
          WinBarNC = { bg = "NONE" },
        }
      end,
    })
    vim.cmd("colorscheme dracula")
  end,
}
