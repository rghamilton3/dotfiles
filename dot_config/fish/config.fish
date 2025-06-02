function fish_greeting
end

set -gx PATH $PATH "/home/rghamilton3/.cargo/bin"
set -gx PATH $PATH "/home/rghamilton3//.config/composer/vendor/bin"
set -gx PATH $PATH "/home/rghamilton3/.local/share/JetBrains/Toolbox/scripts"
set -gx PICO_SDK_PATH /home/rghamilton3/workspace/pico/pico-sdk
set -gx PICO_EXTRAS_PATH /home/rghamilton3/workspace/pico/pico-extras
set -gx EDITOR nvim
set -gx GPG_TTY (tty)
set -gx MOZ_ENABLE_WAYLAND 1
set -gx QT_QPA_PLATFORMTHEME qt6ct

status is-interactive; and begin
    atuin init fish | source
end

set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'
set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#414559,bg:#303446,spinner:#F2D5CF,hl:#E78284 \
--color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#F2D5CF \
--color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 \
--color=selected-bg:#51576D \
--color=border:#414559,label:#C6D0F5"
fzf --fish | source

zoxide init --cmd cd fish | source

if status is-login
    ssh-add ~/.ssh/github
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

alias vim="nvim"
alias n="nvim"
alias v="nvim"
abbr -a -- pn pnpm
abbr -a -- pa 'pnpm add'
abbr -a -- pd 'pnpm dlx'
abbr -a -- pi 'pnpm install'
abbr -a -- n nvim
abbr -a -- a 'php artisan'
abbr -a -- amf 'php artisan migrate:fresh'
abbr -a -- amfs 'php artisan migrate:fresh --seed'
abbr -a -- amodel 'php artisan make:model -m'
abbr -a -- gp 'git push'
abbr -a -- gpa 'git push -u origin --all'
abbr -a -- gs 'git status'
abbr -a -- gcm 'git commit -m'
abbr -a -- gco 'git checkout'
abbr -a -- gcom 'git checkout main'
abbr -a -- gcob 'git checkout -b'
abbr -a -- gaa 'git add -A'
abbr -a -- gap 'git add -p'
abbr -a -- efish 'chezmoi edit --apply ~/.config/fish/config.fish'
abbr -a -- cmcd 'chezmoi cd'
abbr -a -- cma 'chezmoi add'
abbr -a -- cmap 'chezmoi apply'
abbr -a -- cme 'chezmoi edit'
abbr -a -- cmea 'chezmoi edit --apply'
abbr -a -- lg lazygit
abbr -a -- yin 'paru -S --needed'
abbr -a -- yup 'paru -Syu --noconfirm'
abbr -a -- yupr 'paru -Syu --noconfirm; reboot'
abbr -a -- yups 'paru -Syu --noconfirm; shutdown -h now'

# Obsidian
abbr -a -- oo 'cd ~/Vaults/Second\ Brain/'
abbr -a -- oa 'nvim ~/Vaults/Second\ Brain/inbox/*.md'
# abbr -a -- ou 'cd ~/.notion-obsidian-sync/ && node batchUpload.js --lastmod-days-window 5'

# pnpm
set -gx PNPM_HOME "/home/rghamilton3/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

pyenv init - | source
