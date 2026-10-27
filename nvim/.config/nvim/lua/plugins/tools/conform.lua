return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        -- Lua
        lua = { "stylua" },
        -- Web (eslint fix first, then prettier)
        javascript      = { "eslint_d", "prettierd" },
        typescript      = { "eslint_d", "prettierd" },
        javascriptreact = { "eslint_d", "prettierd" },
        typescriptreact = { "eslint_d", "prettierd" },
        svelte          = { "eslint_d", "prettierd" },
        html            = { "prettierd" },
        css             = { "prettierd" },
        json            = { "prettierd" },
        yaml            = { "prettierd" },
        markdown        = { "prettierd" },
        -- Go
        go = { "gofumpt", "goimports" },
        -- Rust (rustfmt ships with the toolchain)
        rust = { "rustfmt" },
        -- C / C++
        c   = { "clang_format" },
        cpp = { "clang_format" },
        -- Zig (zigfmt ships with the toolchain)
        zig = { "zigfmt" },
        -- Haskell
        haskell = { "fourmolu" },
        -- Python
        python = { "isort", "black" },
        -- Shell
        bash = { "shfmt" },
        sh   = { "shfmt" },
        -- Terraform
        terraform      = { "terraform_fmt" },
        tf             = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
      },
      format_on_save = {
        timeout_ms   = 3000, -- prettierd/eslint_d daemons can be slow on first run
        lsp_format = "fallback",
      },
      notify_on_error = true,
      -- 4-space defaults; a project's own config (.prettierrc, stylua.toml, .editorconfig) still wins
      formatters = {
        shfmt = { prepend_args = { "-i", "4" } },
      },
    })
    -- prettierd reads this only when the project has no prettier config
    vim.env.PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath("config") .. "/.prettierrc.json"
  end,
}
