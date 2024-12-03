#!/bin/bash

echo "Setting up your environment with doots..."

# Symlink Neovim config
ln -sf ~/doots/nvim ~/.config/nvim
echo "Symlinked Neovim configuration."

# Symlink tmux config
ln -sf ~/doots/tmux/tmux.conf ~/.tmux.conf
echo "Symlinked tmux configuration."

# Install TPM (Tmux Plugin Manager)
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "Installed tmux TPM (Plugin Manager)."
else
    echo "TMux TPM already installed."
fi

# Reload tmux configuration
tmux source-file ~/.tmux.conf
echo "Reloaded tmux configuration."

# Install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins
echo "Installed tmux plugins."

# Install Neovim Plugins
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
echo "Installed and synchronized Neovim plugins."

# Reload shell configuration
if [ -f ~/.zshrc ]; then
    source ~/.zshrc
    echo "Reloaded shell configuration."
else
    echo "No shell configuration file (.zshrc) found to reload."
fi

echo "Setup complete! Your environment is ready to use with doots."
