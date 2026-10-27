return {
  "echasnovski/mini.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()

    -- ─── mini.pairs — auto close brackets/quotes ──────────────────────────────
    require("mini.pairs").setup({
      modes = { insert = true, command = false, terminal = false },
    })

    -- ─── mini.surround — add/change/delete surroundings ──────────────────────
    -- gsa{motion}{char} → add surround
    -- gsd{char}         → delete surround
    -- gsr{old}{new}     → replace surround
    -- (gs prefix so flash's `s` doesn't wait on timeoutlen)
    require("mini.surround").setup({
      mappings = {
        add            = "gsa",
        delete         = "gsd",
        find           = "gsf",
        find_left      = "gsF",
        highlight      = "gsh",
        replace        = "gsr",
        update_n_lines = "gsn",
      },
    })

    -- ─── mini.ai — smarter text objects ──────────────────────────────────────
    -- e.g. cia = change inner argument, vaf = select outer function
    local ai = require("mini.ai")
    require("mini.ai").setup({
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        c = ai.gen_spec.treesitter({ a = "@class.outer",    i = "@class.inner" }),
      },
    })

  end,
}
