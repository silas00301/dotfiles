{username, ...} : {
  home.sessionVariables = {
    SSH_AUTH_SOCK = "/Users/${username}/.bitwarden-ssh-agent.sock";
  };
}
