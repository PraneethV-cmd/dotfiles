return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/lazydev.nvim",
  },
  config = function()
    -- ─── Capabilities (shared across all servers) ─────────────────────────────

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local ok, blink = pcall(require, "blink.cmp")
    if ok then
      capabilities = blink.get_lsp_capabilities(capabilities)
    end

    -- Apply capabilities to every server via the wildcard config
    vim.lsp.config("*", { capabilities = capabilities })

    -- ─── Diagnostic display ───────────────────────────────────────────────────

    vim.diagnostic.config({
      virtual_text = {
        prefix = "",
        spacing = 4,
        source = false,
        format = function(d) return " " .. d.message .. " " end,
      },
      float = {
        border = "rounded",
        source = true,
      },
      signs = false,                  -- no gutter signs; signcolumn is off
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- ─── LSP keymaps (set on attach) ─────────────────────────────────────────

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd",    vim.lsp.buf.definition,      "Go to definition")
        map("gD",    vim.lsp.buf.declaration,      "Go to declaration")
        map("gI",    vim.lsp.buf.implementation,   "Go to implementation")
        map("gy",    vim.lsp.buf.type_definition,  "Go to type definition")
        map("<leader>rn", vim.lsp.buf.rename,      "Rename symbol")
      end,
    })

    -- ─── Per-server config overrides ─────────────────────────────────────────

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          completion  = { callSnippet = "Replace" },
          diagnostics = { globals = { "vim" } },
          workspace   = { checkThirdParty = false },
          telemetry   = { enable = false },
        },
      },
    })

    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          analyses  = { unusedparams = true, shadow = true },
          staticcheck = true,
          gofumpt = true,
        },
      },
    })

    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = { command = "clippy" },
          cargo = { allFeatures = true },
          procMacro = { enable = true },
        },
      },
    })

    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
      },
    })

    vim.lsp.config("hls", {
      filetypes = { "haskell", "lhaskell", "cabal" },
    })

    vim.lsp.config("terraformls", {
      filetypes = { "terraform", "tf", "terraform-vars" },
    })

    -- ─── Enable servers ───────────────────────────────────────────────────────

    vim.lsp.enable({
      -- Web (linting via eslint_d in nvim-lint, not the eslint LSP)
      "ts_ls", "html", "cssls", "jsonls", "svelte",
      -- Scripting / config
      "lua_ls", "bashls",
      -- Systems
      "clangd", "rust_analyzer", "zls",
      -- Go
      "gopls",
      -- Haskell
      "hls",
      -- Python
      "pyright",
      -- Markdown
      "marksman",
      -- Docker / infra
      "dockerls", "docker_compose_language_service",
      "terraformls",
    })
  end,
}
