return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TodoQuickFix", "TodoLocList", "TodoFzfLua" },
  keys = {
    {
      "]t",
      function() require("todo-comments").jump_next() end,
      desc = "Next todo comment",
    },
    {
      "[t",
      function() require("todo-comments").jump_prev() end,
      desc = "Previous todo comment",
    },
    {
      "<leader>ft",
      function() require("todo-comments.fzf").todo() end,
      desc = "Find todos (fzf)",
    },
    {
      "<leader>fT",
      "<cmd>TodoQuickFix<cr>",
      desc = "Todos (quickfix)",
    },
  },
  config = function()

    -- ─── todo-comments — highlight/search TODO, FIX, HACK, etc. ──────────────
    -- keywords are matched anywhere followed by a colon, e.g. "TODO: fix me"
    -- defaults: FIX | TODO | HACK | WARN | PERF | NOTE | TEST
    require("todo-comments").setup({
      signs = false,               -- signcolumn is off, skip gutter icons
      highlight = {
        multiline = true,          -- highlight the whole comment block
        keyword = "wide",          -- highlight keyword + surrounding chars
        pattern = [[.*<(KEYWORDS)\s*:]], -- keyword must end with a colon
        comments_only = true,      -- treesitter: only inside comments
      },
    })

  end,
}
