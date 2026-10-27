return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  -- load early only when nvim is opened on a directory (`nvim .`)
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("neotree_start_dir", { clear = true }),
      once = true,
      callback = function()
        local arg = vim.fn.argv(0)
        if arg ~= "" and vim.fn.isdirectory(arg) == 1 then require("neo-tree") end
      end,
    })
  end,
  keys = {
    { "-",          "<cmd>Neotree reveal current<cr>", desc = "File explorer (here, current file)" },
    { "<leader>fe", "<cmd>Neotree toggle left<cr>",  desc = "File explorer (toggle)" },
    { "<leader>fE", "<cmd>Neotree reveal left<cr>",  desc = "File explorer (reveal file)" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
      sort_case_insensitive = true,
      default_component_configs = {
        git_status = {
          symbols = {
            added     = "✚",
            modified  = "✹",
            deleted   = "✖",
            renamed   = "➜",
            untracked = "★",
            ignored   = "◌",
            unstaged  = "✗",
            staged    = "✓",
            conflict  = "",
          },
        },
      },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        hijack_netrw_behavior = "open_current",
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
          never_show = { ".DS_Store" },
        },
      },
      window = {
        width = 38,
        mappings = {
          ["<space>"] = "none",
        },
      },
    })
  end,
}
