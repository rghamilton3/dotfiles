set -gx PATH $PATH "/home/rghamilton3/.local/bin"
set -gx PATH $PATH "/home/rghamilton3/go/bin"
set -gx PATH $PATH "/home/rghamilton3/.local/share/JetBrains/Toolbox/scripts"
set -gx EDITOR lvim
alias nvim="lvim"
alias vim="lvim"
alias vi="lvim"

if status is-interactive
    mise activate fish | source
else
    mise activate fish --shims | source
end

set -gx GPG_TTY (tty)

zoxide init --cmd cd fish | source

abbr -a -- pn pnpm
abbr -a -- n lvim
abbr -a -- gp 'git push'
abbr -a -- gpa 'git push -u origin --all'
abbr -a -- gs 'git status'
abbr -a -- gcm 'git commit -m'
abbr -a -- gaa 'git add -A'
abbr -a -- gap 'git add -p'
abbr -a -- yup 'yay -Syuu'
abbr -a -- yrm 'yay -Rns'
abbr -a -- ys  'yay -S'
