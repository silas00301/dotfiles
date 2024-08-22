if status is-interactive
    # enable vim key bindings
    set -g fish_key_bindings fish_vi_key_bindings
end
# to remove the Last login message
clear

# neovim as default editor
export EDITOR="nvim"
# bat as man page viewer
export MANPAGER="batman"

# Set starship prompt config location to folder instead of in .config
export STARSHIP_CONFIG="~/.config/starship/starship.toml"

# brew setup
eval "$(/opt/homebrew/bin/brew shellenv)"
# starship setup
starship init fish | source
# zoxide as cd replacement
eval "$(zoxide init fish --cmd cd)"

# atuin for history
eval "$(atuin init fish)"

# eza as ls
alias ls="eza -la"

# load init commands from not tracked config
source ~/.config/fish/private.fish
