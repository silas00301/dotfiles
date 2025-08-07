{ pkgs, lib, config, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Silas";
        email = "contact@silash.dev";
      };
      ui = {
        default-command = "log";
        pager = lib.mkIf config.programs.bat.enable "bat -p";
        diff-editor = [
          "nvim"
          "-c"
          "DiffEditor $left $right $output"
        ];
      };
      signing = {
        behavior = "own";
        backend = "ssh";
        key = "~/.ssh/id_rsa_private.pub";
      };
      aliases = {
        tug = [
          "bookmark"
          "move"
          "--from"
          "heads(::@ & bookmarks())"
          "--to"
          "@"
        ];
        insert = [
          "new"
          "--insert-before"
          "@"
        ];
        reheat = [
          "rebase"
          "-d"
          "trunk()"
          "-s"
          "roots(trunk()..stack(@))"
        ];
        flip = [
          "util"
          "exec"
          "--"
          "jj-flip"
        ];
        "pr" = [
          "util"
          "exec"
          "--"
          "jj-pr"
        ];
      };
      revset-aliases = {
        "stack()" = "stack(@)";
        "stack(x)" = "stack(x, 2)";
        "stack(x, n)" = "ancestors(reachable(x, mutable()), n)";
      };
      git.private-commits = "description(glob:'private:*')";
    };
  };
  home.packages = [
    (pkgs.writeShellScriptBin "jj-flip" ''
      #!${pkgs.zsh}/bin/zsh
      ${pkgs.jujutsu}/bin/jj bookmark create current --revision @
      ${pkgs.jujutsu}/bin/jj bookmark create previous --revision @-
      ${pkgs.jujutsu}/bin/jj parallelize current previous
      ${pkgs.jujutsu}/bin/jj rebase --branch previous --destination current
      ${pkgs.jujutsu}/bin/jj bookmark forget current
      ${pkgs.jujutsu}/bin/jj bookmark forget previous 
    '')
    (pkgs.writeShellScriptBin "jj-pr" ''
      #!${pkgs.zsh}/bin/zsh
      if [ "$1" = "submit" ]; then
        if [ "$#" -eq 1 ]; then
          rev="@"
        else
          rev="$2"
        fi
        gh pr create --head $(jj log --revisions "$rev" --no-graph --no-pager --template 'self.local_bookmarks()')
      elif [ "$1" = "checkout" ] || [ "$1" = "co" ]; then
        if [ "$#" -eq 1 ]; then
          prs=$(gh pr list --json number,title)
          if [ "$prs" = "[]" ]; then
            echo "No PRs found"
          else
            prId=$(echo "$prs" | jq -r '"#\(.[].number) | \(.[].title)"' | ${pkgs.gum}/bin/gum choose --header "Pick a PR:" | tr -d "\#" | sed "s/ |.*//g")
          fi
        else
          prId="$2"
        fi
          branchName=$(gh pr view $prId --json headRefName --jq .headRefName)
          ${pkgs.jujutsu}/bin/jj new "$branchName"
      fi
    '')
  ];
}
