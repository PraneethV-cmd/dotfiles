return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        -- Web (linting via eslint_d in nvim-lint, not the eslint LSP)
        "ts_ls", "html", "cssls", "jsonls", "svelte",
        -- Scripting / config
        "lua_ls", "bashls",
        -- Systems
        "clangd", "rust_analyzer", "zls",
        -- Go
        "gopls",
        -- Haskell: hls must be installed via GHCup, not Mason
        -- Run: curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
        -- Python
        "pyright",
        -- Markdown
        "marksman",
        -- Docker / infra
        "dockerls", "docker_compose_language_service",
        "terraformls",
      },
      automatic_installation = true,
      -- Servers are explicitly enabled in lspconfig.lua — don't auto-start
      -- every installed package (e.g. stray eslint-lsp / sqlls)
      automatic_enable = false,
    })

    -- Formatters + linters (non-LSP tools), auto-installed on startup
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Web
        "prettierd", "prettier", "eslint_d",
        -- Lua
        "stylua", "luacheck",
        -- Go
        "gofumpt", "goimports", "golangci-lint",
        -- Rust / C / C++
        "clang-format",
        -- Python
        "black", "isort", "ruff",
        -- Shell
        "shfmt", "shellcheck",
        -- Docker / infra
        "hadolint", "tflint",
        -- Haskell
        "fourmolu",
      },
      auto_update = false,
      run_on_start = true,
    })
  end,
}
