# ---------------------------------
# PATH Configuration
# ---------------------------------

# Add custom binaries and local bin directories to PATH
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Add PostgreSQL to PATH
export PATH="/usr/local/opt/postgresql@17/bin:$PATH"

# Add OpenJDK to PATH
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Add Python paths to PATH
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:$PATH"

# Add PNPM to PATH
export PNPM_HOME="$HOME/Library/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

# Add Homebrew binaries to PATH
eval "$(/usr/local/bin/brew shellenv)"

# ---------------------------------
# Oh-My-Zsh Configuration
# ---------------------------------

# Path to Oh-My-Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set Zsh theme
ZSH_THEME="robbyrussell"

# Enable hyphen-insensitive completion (e.g., foo-bar matches foo_bar)
HYPHEN_INSENSITIVE="true"

# Auto-update Oh-My-Zsh
zstyle ':omz:update' mode auto      # Update automatically without asking
zstyle ':omz:update' frequency 13   # Check for updates every 13 days

# Enable command auto-correction
ENABLE_CORRECTION="true"

# Show dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Use timestamps in command history
HIST_STAMPS="mm/dd/yyyy"

# Load plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Source Oh-My-Zsh
source $ZSH/oh-my-zsh.sh
source $ZSH/.zsh_aliases
# ---------------------------------
# History Settings
# ---------------------------------

setopt appendhistory          # Append new history entries to the history file
setopt sharehistory           # Share history across all sessions
HISTSIZE=5000                 # Maximum number of commands in memory
SAVEHIST=10000                # Maximum number of commands in the history file

# ---------------------------------
# Editor Configuration
# ---------------------------------

# Set Neovim as the default editor
export EDITOR='nvim'

# ---------------------------------
# Aliases
# ---------------------------------

# Alias for pip to ensure compatibility
alias pip='pip3'
alias reload_zsh="source ~/.zshrc && echo 'Zsh config reloaded!'"

