source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
#
for _f in $HOME/.config/herdr/plugins/github/herdr-automatic-rename-*/shell/hook.fish
    test -r "$_f"; and source "$_f"; and break
end

set -x EDITOR nvim

abbr -a n nvim
abbr -a c claude
abbr -a yin yay -S --needed --noconfirm
abbr -a edit chezmoi edit --apply
abbr -a efish chezmoi edit --apply ~/.config/fish/config.fish
abbr -a sfish source ~/.config/fish/config.fish
