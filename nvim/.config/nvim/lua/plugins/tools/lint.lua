return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      -- Web (eslint_d: uses each project's local eslint config)
      javascript      = { "eslint_d" },
      typescript      = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte          = { "eslint_d" },
      -- Go
      go = { "golangcilint" },
      -- Python
      python = { "ruff" },
      -- Lua
      lua = { "luacheck" },
      -- Shell
      bash = { "shellcheck" },
      sh   = { "shellcheck" },
      -- Docker
      dockerfile = { "hadolint" },
      -- Terraform
      terraform = { "tflint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("nvim_lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>cl", function() lint.try_lint() end, { desc = "Lint current file" })
  end,
}
