return {
  -- ─── Parser installer ──────────────────────────────────────────────────────
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter").setup()

      local parsers = {
        -- Lua
        "lua", "luadoc",
        -- Web
        "javascript", "typescript", "tsx", "jsdoc", "html", "css", "svelte",
        -- Data / config
        "json", "yaml", "toml",
        -- Systems
        "c", "cpp", "rust", "zig",
        -- Go
        "go", "gomod", "gowork", "gosum",
        -- Haskell
        "haskell",
        -- Python
        "python",
        -- Shell
        "bash",
        -- Markdown
        "markdown", "markdown_inline",
        -- Vim
        "vim", "vimdoc", "query",
        -- Git
        "diff", "gitcommit", "git_config",
        -- Docker / infra
        "dockerfile", "terraform", "hcl",
        -- Misc
        "regex", "comment",
      }

      -- Defer install until after UI is fully ready so the plugin is initialized
      vim.defer_fn(function()
        require("nvim-treesitter.install").install(parsers)
      end, 100)

      -- Enable treesitter highlighting + indent natively per filetype
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- ─── Text objects ──────────────────────────────────────────────────────────
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move   = { set_jumps = true },
      })

      local move = require("nvim-treesitter-textobjects.move")
      local map  = vim.keymap.set

      -- (select text objects af/if/ac/ic live in mini.ai)

      -- ── Move between nodes ───────────────────────────────────────────────
      map("n", "]f", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function start" })
      map("n", "]c", function()
        if vim.wo.diff then return vim.cmd.normal({ "]c", bang = true }) end
        move.goto_next_start("@class.outer", "textobjects")
      end, { desc = "Next class start (next change in diff)" })
      map("n", "]F", function() move.goto_next_end("@function.outer",   "textobjects") end, { desc = "Next function end" })
      map("n", "]C", function() move.goto_next_end("@class.outer",      "textobjects") end, { desc = "Next class end" })

      map("n", "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev function start" })
      map("n", "[c", function()
        if vim.wo.diff then return vim.cmd.normal({ "[c", bang = true }) end
        move.goto_previous_start("@class.outer", "textobjects")
      end, { desc = "Prev class start (prev change in diff)" })
      map("n", "[F", function() move.goto_previous_end("@function.outer",   "textobjects") end, { desc = "Prev function end" })
      map("n", "[C", function() move.goto_previous_end("@class.outer",      "textobjects") end, { desc = "Prev class end" })
    end,
  },
}
