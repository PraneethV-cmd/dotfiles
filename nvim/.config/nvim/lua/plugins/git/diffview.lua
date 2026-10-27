local function base_branch()
  for _, ref in ipairs({ "origin/main", "origin/master", "main", "master", "HEAD~1" }) do
    vim.fn.system({ "git", "rev-parse", "--verify", "--quiet", ref })
    if vim.v.shell_error == 0 then
      return ref
    end
  end
  return nil
end

return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
  },
  keys = {
    { "<leader>gv", "<cmd>DiffviewOpen HEAD<cr>", desc = "Diffview (all local changes)" },
    {
      "<leader>gV",
      function()
        local base = base_branch()
        if not base then
          vim.notify("Diffview: no base branch found (main/master)", vim.log.levels.WARN)
          return
        end
        vim.cmd("DiffviewOpen " .. base .. "...HEAD")
      end,
      desc = "Diffview (branch vs main)",
    },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current file)" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Repo history" },
    { "<leader>gq", "<cmd>DiffviewClose<cr>",         desc = "Close diffview" },
  },
  config = function()
    require("diffview").setup({
      enhanced_diff_hl = true,
      view = {
        default = { layout = "diff2_horizontal" },
        merge_tool = { layout = "diff3_mixed" },
      },
      file_panel = {
        listing_style = "tree",
        win_config = { position = "left", width = 35 },
      },
    })
  end,
}
