return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<cr>",       desc = "Find files" },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>",   desc = "Live grep" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>",     desc = "Buffers" },
    { "<leader>fh", "<cmd>FzfLua help_tags<cr>",   desc = "Help tags" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>",    desc = "Recent files" },
    { "<leader>fc", "<cmd>FzfLua commands<cr>",    desc = "Commands" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>",     desc = "Keymaps" },
    { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>",  desc = "Document symbols" },
    { "<leader>fS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
    { "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>",  desc = "Document diagnostics" },
    { "<leader>fD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },
    { "gr",         "<cmd>FzfLua lsp_references<cr>",        desc = "LSP references" },
    { "<leader>fw", "<cmd>FzfLua grep_cword<cr>",  desc = "Grep word under cursor" },
    { "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>",  desc = "Grep WORD under cursor" },
    { "<leader>f/", "<cmd>FzfLua blines<cr>",      desc = "Search current buffer" },
    { "<leader>gG", "<cmd>FzfLua git_status<cr>",  desc = "Git changed files" },
  },
  config = function()
    require("fzf-lua").setup({
      winopts = {
        height = 0.85,
        width  = 0.85,
        row    = 0.35,
        col    = 0.50,
        border = "rounded",
        preview = {
          border   = "rounded",
          layout   = "flex",
          flip_columns = 120,
          vertical = "down:50%",
          horizontal = "right:50%",
        },
      },
      keymap = {
        builtin = {
          ["<C-d>"]     = "preview-page-down",
          ["<C-u>"]     = "preview-page-up",
          ["<C-f>"]     = "preview-page-down",
          ["<C-b>"]     = "preview-page-up",
        },
        fzf = {
          ["ctrl-d"]    = "preview-page-down",
          ["ctrl-u"]    = "preview-page-up",
          ["ctrl-a"]    = "toggle-all",
        },
      },
      fzf_opts = {
        ["--layout"] = "reverse",
        ["--info"]   = "inline",
      },
      files = {
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
      },
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=512",
      },
    })
  end,
}
