# Dotfiles for Arch Linux (BTW)

## New machine setup:
1. Ensure the following software is installed:
   - [chezmoi](https://www.chezmoi.io) - For dotfile management
   - [wezterm](https://wezfurlong.org/wezterm) - Terminal of choice
   - [zsh](https://www.zsh.org) - Shell of choice
   - [zimfw](https://zimfw.sh) - Zsh configuration framework
   - [neovim](https://neovim.io) - Editor of choice
   - [yay](https://github.com/Jguer/yay) - [AUR](https://aur.archlinux.org/) helper
   - [fzf](https://github.com/junegunn/fzf) - Fuzzy file finder
   - [fd](https://github.com/sharkdp/fd) - A simple, fast and user-friendly alternative to `find`
   - [ripgrep](https://github.com/BurntSushi/ripgrep) - A better silver-searcher and grep
   - [zoxide](https://github.com/ajeetdsouza/zoxide) - A smarter `cd` command
   - [exa](https://eza.rocks) - A modern replacement for `ls`
   - [bat](https://github.com/sharkdp/bat) - A `cat` clone with wings
   - [btop](https://github.com/aristocratos/btop) - A better `top`
   - [atuin](https://atuin.sh/) - Sync, search, and backup shell history
   - [vifm](https://vifm.info) - A VIM-inspired terminal-based file manager
   - [starship](https://starship.rs) - The minimal, blazing-fast, and infinitely customizable prompt for any shell
   - [lazyvim](https://www.lazyvim.org) - LazyVim is a Neovim setup powered by 💤 lazy.nvim
2. Initialize chezmoi
   > $ chezmoi init --apply rghamilton3
