{ username, ... }:
{
  home.sessionVariables = {
    SSH_AUTH_SOCK = "/home/${username}/.bitwarden-ssh-agent.sock";
  };
}
