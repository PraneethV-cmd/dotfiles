return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
      preset = "modern",
      delay = 300,
      win = {
        border = "rounded",
      },
    })

    -- Register key group descriptions
    wk.add({
      { "<leader>a",  group = "AI / Claude Code" },
      { "<leader>c",  group = "Code" },
      { "<leader>m",  group = "Messages / Health" },
      { "<leader>d",  group = "Delete (void)" },
      { "<leader>e",  group = "Diagnostics" },
      { "<leader>f",  group = "Find (fzf)" },
      { "<leader>g",  group = "Git" },
      { "<leader>h",  group = "Harpoon" },
      { "<leader>p",  group = "Paste" },
      { "<leader>r",  group = "Rename" },
      { "<leader>s",  group = "Splits" },
      { "<leader>x",  group = "Buffer close" },
      { "g",          group = "Goto" },
      { "gp",         group = "Peek (float)" },
    })
  end,
}
