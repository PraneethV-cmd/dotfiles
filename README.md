# dotfiles

My macOS setup: **Neovim, Ghostty, zsh, btop**, plus everything Homebrew installs.
Configs live here and get symlinked into place with [GNU Stow](https://www.gnu.org/software/stow/).

```
dotfiles/
├── Brewfile        # every brew formula, cask, font (+ go/cargo/uv/npm tools)
├── install.sh      # one-shot setup for a fresh Mac
├── nvim/           # → ~/.config/nvim  and ~/.config/stylua
├── ghostty/        # → ~/.config/ghostty
├── btop/           # → ~/.config/btop
└── zsh/            # → ~/.zshrc, ~/.zprofile, ~/.zshenv
```

Each top-level folder is a stow "package": its contents mirror `$HOME`.
So `nvim/.config/nvim` ends up as the symlink `~/.config/nvim → ~/dotfiles/nvim/.config/nvim`.

---

## Setting up a fresh Mac (after a reset)

**1. Install the Command Line Tools** (gives you `git`):

```sh
xcode-select --install
```

Wait for the popup to finish.

**2. Get SSH access to GitHub.** Restore `~/.ssh/id_ed25519` (+ `.pub`) from your backup,
*or* make a new key and add it at https://github.com/settings/keys:

```sh
ssh-keygen -t ed25519 -C "you@example.com"
pbcopy < ~/.ssh/id_ed25519.pub      # paste into GitHub → New SSH key
ssh -T git@github.com               # should say "Hi PraneethV-cmd!"
```

**3. Clone and run the installer:**

```sh
git clone git@github.com:PraneethV-cmd/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

It installs Homebrew, everything in the `Brewfile`, Oh My Zsh, backs up any existing
configs to `~/dotfiles-backup-<date>/`, symlinks everything, and installs the Neovim plugins
at the exact versions in `lazy-lock.json`. It's safe to re-run.

**4. Put your secrets back.** API keys are **not** in this repo. Fill in `~/.secrets.zsh`:

```sh
nvim ~/.secrets.zsh
# export DEEPSEEK_API_KEY="..."
```

**5. Log back into tools** (tokens never live in the repo):

```sh
gh auth login
gcloud auth login        # if needed
```

**6. Open Ghostty**, then run `nvim`. On first launch Mason installs the language servers,
formatters and linters. That takes a minute; `:Mason` shows progress.

Done.

---

## Day-to-day

Configs are symlinks, so **edit them normally** (`nvim ~/.config/nvim/...`). The edit is
already in the repo. Then save it:

```sh
cd ~/dotfiles
git add -A && git commit -m "nvim: tweak keymaps" && git push
```

On another machine: `cd ~/dotfiles && git pull`. Symlinks mean nothing else to do.

### Installed a new app with brew? Update the Brewfile

```sh
brew bundle dump --file=~/dotfiles/Brewfile --force
```

(Re-add the 3 lines under `# Added for a fresh machine` at the bottom if they disappear.
`dump` only writes what's installed *through brew*.)

### Bring a new tool's config under the repo

Example, kitty:

```sh
mkdir -p ~/dotfiles/kitty/.config
mv ~/.config/kitty ~/dotfiles/kitty/.config/
cd ~/dotfiles && stow kitty
```

Then add `kitty` to `PACKAGES` in `install.sh`.

### Undo / remove the symlinks

```sh
cd ~/dotfiles && stow -D nvim     # removes the ~/.config/nvim symlink only
```

---

## What's configured

### Neovim
- **Plugin manager:** lazy.nvim. Versions pinned in `lazy-lock.json` (`:Lazy restore` to match it).
- **Theme:** Dracula, transparent so Ghostty's background shows through.
- **Indent:** 4 spaces everywhere, including YAML. A project's `.editorconfig`, `.prettierrc`
  or `stylua.toml` still wins. Defaults for formatters live in `nvim/.config/nvim/.prettierrc.json`
  and `nvim/.config/stylua/stylua.toml`.
- **Files:** neo-tree (`<leader>fe`, `-`, or `nvim .`). **Find:** fzf-lua (`<leader>f…`).
- **LSP / format / lint:** Mason + nvim-lspconfig, conform (format on save), nvim-lint.
- **Jump:** flash (`s`). **Surround:** `gsa` / `gsd` / `gsr`.
- **Git:** gitsigns (`]g` `[g`, `<leader>g…`), diffview (`<leader>gv`).
- **AI:** claudecode.nvim (`<leader>a…`).
- Full keymap list: [`nvim/.config/nvim/KEYMAP.md`](nvim/.config/nvim/KEYMAP.md), or `<leader>?` inside nvim.

### Ghostty
Dracula theme on a `#101113` background, CaskaydiaCove Nerd Font (installed by the Brewfile),
95% opacity + blur. `macos-option-as-alt = true` so Option works as Alt in nvim.

### zsh
Oh My Zsh (`smt` theme, `git` plugin), zsh-autosuggestions, direnv, nvm, bun.
Secrets go in `~/.secrets.zsh` (sourced at the end of `.zshrc`, ignored by git).

### btop
Monokai theme, braille graphs.

---

## Troubleshooting

| Problem | Fix |
|---|---|
| Icons show as boxes | Font missing: `brew install --cask font-caskaydia-cove-nerd-font`, restart Ghostty |
| `stow` says "existing target is not owned by stow" | A real file is in the way. Move it aside (`mv ~/.zshrc ~/.zshrc.old`) and re-run `stow zsh` |
| An LSP doesn't attach | `:Mason` to check it's installed, `:checkhealth vim.lsp` |
| Haskell LSP | `hls` comes from the Brewfile (`haskell-language-server`), not Mason |
| `<A-j>` / `<A-k>` type `∆˚` | Ghostty config not linked: `ls -la ~/.config/ghostty` |
| Some Brewfile line fails | Usually a renamed or removed formula. Delete that line and re-run `brew bundle` |
