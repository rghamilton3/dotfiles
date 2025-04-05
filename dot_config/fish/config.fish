source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

set -gx PATH $PATH "/home/rghamilton3/.local/bin"
set -gx PATH $PATH "/home/rghamilton3/.cargo/bin"

set -gx BROWSER vivaldi-stable

# NVIM
set -gx EDITOR nvim
alias vim="nvim"
abbr -a -- n nvim

# fzf
set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'
fzf --fish | source

zoxide init --cmd cd fish | source

# PHP
abbr -a -- a 'php artisan'
abbr -a -- amf 'php artisan migrate:fresh'
abbr -a -- amfs 'php artisan migrate:fresh --seed'
abbr -a -- amodel 'php artisan make:model -m'

# Git
abbr -a -- gp 'git push'
abbr -a -- gpa 'git push -u origin --all'
abbr -a -- gs 'git status'
abbr -a -- gcm 'git commit -m'
abbr -a -- gco 'git checkout'
abbr -a -- gcom 'git checkout main'
abbr -a -- gcob 'git checkout -b'
abbr -a -- gaa 'git add -A'
abbr -a -- gap 'git add -p'
abbr -a -- lg lazygit

# Chezmoi
abbr -a -- efish 'chezmoi edit --apply ~/.config/fish/config.fish'
abbr -a -- cmcd 'chezmoi cd'
abbr -a -- cma 'chezmoi add'
abbr -a -- cmap 'chezmoi apply'
abbr -a -- cme 'chezmoi edit'
abbr -a -- cmea 'chezmoi edit --apply'

# System
abbr -a -- parupr 'paru -Syu --noconfirm; reboot'
abbr -a -- parups 'paru -Syu --noconfirm; shutdown -h now'

# Obsidian
abbr -a -- oo 'cd ~/obsidian-vault/Second\ Brain/'
abbr -a -- oa 'vim ~/obsidian-vault/Second\ Brain/inbox/*.md'
# abbr -a -- ou 'cd ~/.notion-obsidian-sync/ && node batchUpload.js --lastmod-days-window 5'

# pnpm
abbr -a -- pn pnpm
abbr -a -- pa 'pnpm add'
abbr -a -- pd 'pnpm dlx'
abbr -a -- pi 'pnpm install'
set -gx PNPM_HOME "/home/rghamilton3/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

pyenv init - | source

# Autostart TMUX
status is-interactive; and begin
    set fish_tmux_autostart true
end
