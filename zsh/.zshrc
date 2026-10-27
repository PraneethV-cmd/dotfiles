# ─── Oh My Zsh ───────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="smt"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ─── Env ─────────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim

# brew shellenv is in ~/.zprofile
eval "$(direnv hook zsh)"

# nvm (Homebrew)
export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

# Fish-like inline suggestions from history. Accept with → or End.
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ─── Secrets (API keys etc.) — local only, never committed ───────────────────
[ -f "$HOME/.secrets.zsh" ] && source "$HOME/.secrets.zsh"
