# Neovim Keymaps

> Leader = `<Space>`

---

## Navigation

### Windows

| Key      | Action                 |
| -------- | ---------------------- |
| `Ctrl+h` | Go to left window      |
| `Ctrl+j` | Go to lower window     |
| `Ctrl+k` | Go to upper window     |
| `Ctrl+l` | Go to right window     |
| `Ctrl+↑` | Increase window height |
| `Ctrl+↓` | Decrease window height |
| `Ctrl+←` | Decrease window width  |
| `Ctrl+→` | Increase window width  |

### Splits

| Key          | Action               |
| ------------ | -------------------- |
| `<leader>sv` | Split vertical       |
| `<leader>sh` | Split horizontal     |
| `<leader>se` | Equalize split sizes |
| `<leader>sc` | Close split          |

### Buffers

| Key         | Action          |
| ----------- | --------------- |
| `Tab`       | Next buffer     |
| `Shift+Tab` | Previous buffer |
| `<leader>x` | Close buffer    |

### Scrolling

| Key      | Action                            |
| -------- | --------------------------------- |
| `Ctrl+d` | Scroll down (cursor centered)     |
| `Ctrl+u` | Scroll up (cursor centered)       |
| `n`      | Next search result (centered)     |
| `N`      | Previous search result (centered) |

---

## File Explorer — Neo-tree (left sidebar)

| Key          | Action                                                   |
| ------------ | -------------------------------------------------------- |
| `<leader>fe` | Toggle file tree (left sidebar)                          |
| `<leader>fE` | Reveal current file in tree                              |
| `-`          | Open tree full-window at current file (also `nvim .`)    |
| `Enter`/`l`  | Open file                                                |
| `space`      | Toggle file/directory                                    |
| `a` / `A`    | Add file / add directory                                 |
| `d`          | Delete (system trash)                                    |
| `r`          | Rename                                                   |
| `y` / `x`    | Copy / cut to clipboard                                  |
| `p`          | Paste from clipboard                                     |
| `R`          | Refresh tree                                             |
| `H`          | Toggle hidden + gitignored files                         |
| `?`          | Show all tree mappings                                   |

Per-file git status: `✚` added · `✹` modified · `✖` deleted · `➜` renamed · `★` untracked · `✓` staged · `✗` unstaged · conflict. Auto-refreshes on external edits (libuv watcher), follows the current file.

---

## Find — FZF

| Key          | Action                       |
| ------------ | ---------------------------- |
| `<leader>ff` | Find files                   |
| `<leader>fg` | Live grep (search text)      |
| `<leader>fb` | Open buffers                 |
| `<leader>fr` | Recent files                 |
| `<leader>fh` | Help tags                    |
| `<leader>fc` | Commands                     |
| `<leader>fk` | Keymaps                      |
| `<leader>fs` | Document symbols             |
| `<leader>fS` | Workspace symbols            |
| `<leader>fd` | Document diagnostics         |
| `<leader>fD` | Workspace diagnostics        |
| `<leader>fw` | Grep word under cursor       |
| `<leader>fW` | Grep WORD under cursor       |
| `<leader>f/` | Search inside current buffer |
| `<leader>ft` | Find TODOs/FIXMEs (fzf)      |
| `<leader>fT` | Find TODOs (quickfix list)   |

---

## Todo Comments

| Key             | Action                              |
| --------------- | ----------------------------------- |
| `]t`            | Next todo comment                   |
| `[t`            | Previous todo comment               |
| `<leader>ft`    | Search project todos (fzf)          |
| `<leader>fT`    | List project todos in quickfix      |
| `:TodoQuickFix` | Open all todos in the quickfix list |
| `:TodoLocList`  | Open all todos in the location list |

---

## LSP — Language Server

| Key          | Action                           |
| ------------ | -------------------------------- |
| `gd`         | Go to definition (jump)          |
| `gD`         | Go to declaration                |
| `gr`         | Go to references (fzf list)      |
| `gI`         | Go to implementation             |
| `gy`         | Go to type definition            |
| `K`          | Hover docs (signature pops up automatically while typing) |
| `<leader>rn` | Rename symbol                    |
| `<leader>ca` | Code actions (with diff preview) |

### Peek — Stay in your file, view in float

| Key   | Action                |
| ----- | --------------------- |
| `gpd` | Peek definition       |
| `gpi` | Peek implementation   |
| `gpy` | Peek type definition  |
| `gpr` | Peek references (fzf) |
| `gpc` | Close all peek floats |

### Diagnostics

| Key         | Action                |
| ----------- | --------------------- |
| `[d` / `]d` | Prev / next diagnostic (built in) |
| `<leader>e` | Show diagnostic float |

---

## Harpoon — File Bookmarks

| Key          | Action                |
| ------------ | --------------------- |
| `<leader>ha` | Add current file      |
| `<leader>hh` | Open harpoon menu     |
| `<leader>h1` | Jump to file 1        |
| `<leader>h2` | Jump to file 2        |
| `<leader>h3` | Jump to file 3        |
| `<leader>h4` | Jump to file 4        |
| `<leader>hp` | Previous harpoon file |
| `<leader>hn` | Next harpoon file     |

---

## Flash — Jump Anywhere

| Key      | Mode             | Action                                    |
| -------- | ---------------- | ----------------------------------------- |
| `s`      | Normal/Visual/Op | Flash jump (type 2 chars → labels appear) |
| `S`      | Normal/Visual/Op | Flash treesitter select                   |
| `r`      | Operator         | Flash remote (act on distant text)        |
| `R`      | Operator/Visual  | Flash treesitter search                   |
| `Ctrl+s` | Command          | Toggle flash in `/` search                |

---

## Git — Gitsigns

| Key          | Action                    |
| ------------ | ------------------------- |
| `]g`         | Next hunk                 |
| `[g`         | Previous hunk             |
| `<leader>gs` | Stage hunk                |
| `<leader>gr` | Reset hunk                |
| `<leader>gw` | Toggle inline word diff   |
| `<leader>gS` | Stage entire buffer       |
| `<leader>gu` | Undo stage hunk           |
| `<leader>gR` | Reset entire buffer       |
| `<leader>gp` | Preview hunk              |
| `<leader>gb` | Blame current line (full) |
| `<leader>gd` | Diff this file            |
| `<leader>gD` | Diff this file against ~  |
| `<leader>gB` | Gutter: toggle diff vs main (whole branch) |
| `<leader>gG` | Git changed files (picker)|
| `<leader>gv` | Diffview: all local changes |
| `<leader>gV` | Diffview: branch vs main    |
| `<leader>gh` | Diffview: file history      |
| `<leader>gH` | Diffview: repo history      |
| `<leader>gq` | Close diffview              |
| `ih`         | (text object) Select hunk |

---

## Editing

### Surround — mini.surround

| Key                | Action                                                  |
| ------------------ | ------------------------------------------------------- |
| `gsa{motion}{char}` | Add surround — e.g. `gsaiw"` wraps word in quotes        |
| `gsd{char}`         | Delete surround — e.g. `gsd"` removes surrounding quotes |
| `gsr{old}{new}`     | Replace surround — e.g. `gsr"'` changes `"` to `'`       |
| `gsf{char}`         | Find surround right                                     |
| `gsF{char}`         | Find surround left                                      |
| `gsh{char}`         | Highlight surround                                      |

### Comments — built in

| Key          | Action                                          |
| ------------ | ----------------------------------------------- |
| `gc{motion}` | Toggle comment — e.g. `gcip` comments paragraph |
| `gcc`        | Toggle comment on current line                  |
| `gc`         | (Visual) Toggle comment on selection            |

### Move Lines

| Key     | Action                   |
| ------- | ------------------------ |
| `Alt+j` | Move line/selection down |
| `Alt+k` | Move line/selection up   |

### Indenting (Visual)

| Key | Action                         |
| --- | ------------------------------ |
| `>` | Indent right (stays in visual) |
| `<` | Indent left (stays in visual)  |

### Paste

| Key         | Action                                 |
| ----------- | -------------------------------------- |
| `<leader>p` | (Visual) Paste without losing register |
| `<leader>d` | Delete to void (nothing copied)        |

---

## Text Objects — Treesitter + mini.ai

> Use with any operator: `v`, `d`, `c`, `y`

| Key         | Selects                                           |
| ----------- | ------------------------------------------------- |
| `af` / `if` | Outer / inner function                            |
| `ac` / `ic` | Outer / inner class                               |
| `aa` / `ia` | Outer / inner argument                            |
| `ab` / `ib` | Outer / inner block                               |
| `ao` / `io` | Outer / inner conditional/loop/block (treesitter) |

### Treesitter Moves

| Key         | Action                         |
| ----------- | ------------------------------ |
| `]f` / `[f` | Next / previous function start |
| `]F` / `[F` | Next / previous function end   |
| `]c` / `[c` | Next / previous class start (next/prev change in diff mode) |
| `]C` / `[C` | Next / previous class end      |

---

## Format & Lint

| Key          | Action                       |
| ------------ | ---------------------------- |
| `<leader>cf` | Format buffer (or selection) |
| `<leader>cl` | Lint current file            |

---

## Dashboard — Alpha (start screen)

| Key | Action                     |
| --- | -------------------------- |
| `f` | Find file                  |
| `r` | Recent files               |
| `g` | Live grep                  |
| `e` | File explorer              |
| `c` | Browse config              |
| `?` | Open keymap reference      |
| `l` | Open Lazy (plugin manager) |
| `m` | Open Mason (LSP installer) |
| `q` | Quit                       |

---

## Messages & Health

| Key          | Action                                           |
| ------------ | ------------------------------------------------ |
| `<leader>ml` | Open error/message log float (all nvim messages) |
| `<leader>mt` | Treesitter health check                          |
| `<leader>mh` | Run checkhealth (prompts for plugin name)        |
| `dc`         | (inside log float) Clear all messages            |

---

-- TODO: asdasd

## Misc

| Key         | Action                     |
| ----------- | -------------------------- |
| `Ctrl+s`    | Save file                  |
| `Ctrl+q`    | Quit                       |
| `Esc`       | Clear search highlight     |
| `<leader>?` | Open this keymap reference |
