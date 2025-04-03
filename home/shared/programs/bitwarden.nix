{pkgs, username, ...} : {
  home.packages = [
    pkgs.bitwarden-desktop
  ];

  home.sessionVariables = {
    SSH_AUTH_SOCK = "/Users/${username}/.bitwarden-ssh-agent.sock";
  };
}
