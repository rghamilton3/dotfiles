if status is-interactive
    # Commands to run in interactive sessions can go here
end

zoxide init --cmd cd fish | source
~/.local/bin/mise activate fish | source
abbr -a -- n nvim
