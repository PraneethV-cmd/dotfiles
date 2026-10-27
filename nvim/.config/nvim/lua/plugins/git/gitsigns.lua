return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "Gitsigns" },
  config = function()
    require("gitsigns").setup({
      -- Show staged changes in the gutter too (agents often `git add` without
      -- committing). Staged signs fall back to the normal sign colors.
      signs_staged_enable = true,
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "▁" },
        topdelete    = { text = "▔" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      signs_staged = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "▁" },
        topdelete    = { text = "▔" },
        changedelete = { text = "▎" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = { follow_files = true },
      attach_to_untracked = true,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      preview_config = {
        border = "rounded",
      },

      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, keys, func, desc)
          vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "Git: " .. desc })
        end

        -- Navigation
        map("n", "]g", function()
          if vim.wo.diff then return vim.cmd.normal({ "]c", bang = true }) end
          gs.nav_hunk("next")
        end, "Next hunk")

        map("n", "[g", function()
          if vim.wo.diff then return vim.cmd.normal({ "[c", bang = true }) end
          gs.nav_hunk("prev")
        end, "Prev hunk")

        -- Actions
        map("n", "<leader>gs", gs.stage_hunk,      "Stage hunk")
        map("n", "<leader>gr", gs.reset_hunk,      "Reset hunk")
        map("n", "<leader>gw", gs.toggle_word_diff, "Toggle inline word diff")
        map("n", "<leader>gS", gs.stage_buffer,    "Stage buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>gR", gs.reset_buffer,    "Reset buffer")
        map("n", "<leader>gp", gs.preview_hunk,    "Preview hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>gd", gs.diffthis,        "Diff this")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff this ~")

        -- Toggle diff against the base branch's merge-base. In worktrees the
        -- agent's work is usually committed, so the gutter shows nothing
        -- against HEAD — this reveals the whole branch's changes as signs.
        map("n", "<leader>gB", function()
          local config = require("gitsigns.config").config
          if config.base and config.base ~= "index" then
            gs.change_base(nil, true)
            vim.notify("GitSigns: diff base reset to index")
            return
          end
          local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h")
          local ref
          for _, r in ipairs({ "origin/main", "main", "origin/master", "master" }) do
            vim.fn.system({ "git", "-C", dir, "rev-parse", "--verify", "--quiet", r .. "^{commit}" })
            if vim.v.shell_error == 0 then
              ref = r
              break
            end
          end
          if not ref then
            vim.notify("GitSigns: no main/master branch found", vim.log.levels.WARN)
            return
          end
          local mb = vim.fn.system({ "git", "-C", dir, "merge-base", "HEAD", ref }):gsub("%s+", "")
          if mb == "" then
            vim.notify("GitSigns: no merge-base with " .. ref, vim.log.levels.WARN)
            return
          end
          gs.change_base(mb, true)
          vim.notify("GitSigns: diffing vs " .. ref .. " @" .. mb:sub(1, 7))
        end, "Toggle diff vs main (whole branch)")

        -- Text object — select hunk
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
      end,
    })
  end,
}
