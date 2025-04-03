{ pkgs, ... }:

{
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.nerd-fonts.geist-mono
    pkgs.maple-mono.NF
    # pkgs.bitwarden-cli
    pkgs.rustup
    pkgs.bat
    pkgs.bat-extras.prettybat
    pkgs.bat-extras.batwatch
    pkgs.bat-extras.batman
    pkgs.bat-extras.batgrep
    pkgs.bat-extras.batpipe
    pkgs.bat-extras.batdiff
    pkgs.lazydocker
    pkgs.dogdns
    pkgs.glow
    pkgs.obsidian
    pkgs.spotify
    pkgs.jujutsu
  ];

  imports = [
    ./themes

    ./programs/atuin.nix
    ./programs/bash.nix
    ./programs/bat.nix
    ./programs/bottom.nix
    ./programs/bun.nix
    ./programs/direnv.nix
    ./programs/eza.nix
    ./programs/fastfetch.nix
    ./programs/fd.nix
    ./programs/fish.nix
    ./programs/fzf.nix
    # ./programs/ghostty.nix
    ./programs/git/git.nix
    ./programs/github-cli.nix
    ./programs/jq.nix
    ./programs/kitty.nix
    ./programs/lazygit.nix
    ./programs/nixvim.nix
    ./programs/ripgrep.nix
    ./programs/starship.nix
    ./programs/thefuck.nix
    ./programs/tmux.nix
    ./programs/zoxide.nix
    ./programs/zellij.nix
    ./programs/zsh.nix
  ];

  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
