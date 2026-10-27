return {
  -- Code actions with diff preview
  {
    "aznhe21/actions-preview.nvim",
    event = "LspAttach",
    config = function()
      require("actions-preview").setup({
        diff = {
          ctxlen = 3,
        },
        highlight_command = {},
        backend = { "nui" },
      })

      -- Override the default code action keymap with the preview version
      vim.keymap.set({ "n", "v" }, "<leader>ca", require("actions-preview").code_actions, {
        desc = "LSP: Code actions (preview)",
      })
    end,
  },

  -- Peek at definition/implementation in a float without jumping away
  {
    "rmagatti/goto-preview",
    event = "LspAttach",
    config = function()
      require("goto-preview").setup({
        width = 120,
        height = 25,
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        default_mappings = false,
        debug = false,
        opacity = nil,
        resizing_mappings = false,
        post_open_hook = nil,
        references = {
          provider = "fzf_lua",
        },
        focus_on_open = true,
        dismiss_on_move = false,
        force_close = true,
        bufhidden = "wipe",
        stack_floating_preview_windows = true,
        preview_window_title = { enable = true, position = "left" },
      })

      local gp = require("goto-preview")
      local map = vim.keymap.set

      -- gpd — peek definition in float (stay in your file)
      map("n", "gpd", gp.goto_preview_definition,      { desc = "LSP: Peek definition" })
      -- gpi — peek implementation
      map("n", "gpi", gp.goto_preview_implementation,  { desc = "LSP: Peek implementation" })
      -- gpy — peek type definition
      map("n", "gpy", gp.goto_preview_type_definition, { desc = "LSP: Peek type definition" })
      -- gpr — peek references
      map("n", "gpr", gp.goto_preview_references,      { desc = "LSP: Peek references" })
      -- gpc — close all preview floats
      map("n", "gpc", gp.close_all_win,                { desc = "LSP: Close all peek floats" })
    end,
  },
}
