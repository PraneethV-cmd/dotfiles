#!/usr/bin/env bash
# Rebuild this setup on a fresh Mac. Safe to re-run.
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
PACKAGES=(nvim ghostty btop zsh)

# 1. Xcode Command Line Tools (git, make, clang)
if ! xcode-select -p >/dev/null 2>&1; then
    xcode-select --install
    echo "Finish the Command Line Tools install, then re-run ./install.sh"
    exit 1
fi

# 2. Homebrew
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# 3. Packages, apps, fonts
brew bundle --file="$DOTFILES/Brewfile" || echo "!! some Brewfile entries failed, see above (re-run later)"

# 4. Oh My Zsh (keep our .zshrc)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# 5. Move any existing real files out of the way, then symlink with stow
BACKUP="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
for target in .zshrc .zprofile .zshenv .config/nvim .config/ghostty .config/btop .config/stylua; do
    if [ -e "$HOME/$target" ] && [ ! -L "$HOME/$target" ]; then
        mkdir -p "$BACKUP/$(dirname "$target")"
        mv "$HOME/$target" "$BACKUP/$target"
        echo "backed up ~/$target -> $BACKUP/$target"
    fi
done
mkdir -p "$HOME/.config"
stow -d "$DOTFILES" -t "$HOME" --restow "${PACKAGES[@]}"

# 6. Local secrets file (never committed)
[ -f "$HOME/.secrets.zsh" ] || { echo "# export SOME_API_KEY=..." > "$HOME/.secrets.zsh"; chmod 600 "$HOME/.secrets.zsh"; }

# 7. Neovim plugins at the exact commits in lazy-lock.json
nvim --headless "+Lazy! restore" +qa

echo
echo "Done. Open a new Ghostty window. In nvim, Mason installs LSPs/formatters on first launch."
