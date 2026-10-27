return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
        hover = {
          enabled = true,
          silent = true,
        },
        signature = {
          enabled = false,  -- blink.cmp shows signatures
        },
        -- Show LSP progress in a float
        progress = {
          enabled = true,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          throttle = 1000 / 30,
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,        -- "/" and "?" use the classic bottom cmdline
        command_palette = true,      -- cmdline + popupmenu together
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,        -- border on hover/signature floats
      },
      routes = {
        -- Send long messages to a split
        {
          filter = { event = "msg_show", min_height = 20 },
          view = "split",
        },
        -- Hide written messages
        {
          filter = { event = "msg_show", kind = "", find = "written" },
          opts = { skip = true },
        },
        -- Hide search count noise
        {
          filter = { event = "msg_show", kind = "search_count" },
          opts = { skip = true },
        },
      },
      views = {
        cmdline_popup = {
          border = { style = "rounded" },
          position = { row = "50%", col = "50%" },
          size = { width = 60, height = "auto" },
        },
        popupmenu = {
          relative = "editor",
          position = { row = "57%", col = "50%" },
          size = { width = 60, height = 10 },
          border = { style = "rounded", padding = { 0, 1 } },
          win_options = { winhighlight = { Normal = "Normal", FloatBorder = "FloatBorder" } },
        },
        mini = {
          win_options = { winblend = 0 },
        },
      },
    })

    -- Notify setup
    require("notify").setup({
      background_colour = "#00000000",
      render = "compact",
      stages = "fade",
      timeout = 3000,
      top_down = false,
    })
  end,
}
