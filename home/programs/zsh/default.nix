{ config
, pkgs
, ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      save = 10000;
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    sessionVariables = {
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
    };

    envExtra = ''
      export LANG="en_US.UTF-8"
      export LC_COLLATE="en_US.UTF-8"
      export LC_CTYPE="en_US.UTF-8"
      export LC_MESSAGES="en_US.UTF-8"
      export LC_MONETARY="en_US.UTF-8"
      export LC_NUMERIC="en_US.UTF-8"
      export LC_TIME="en_US.UTF-8"
      export LC_ALL="en_US.UTF-8"
      export SUDO_PROMPT=$'Password for ->\033[32;05;16m %u\033[0m  '
      export FZF_DEFAULT_OPTS="
        --border
        --prompt 'λ '
        --pointer ''
        --marker ''
      "
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "nix-zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-community";
          repo = "nix-zsh-completions";
          rev = "refs/tags/0.5.1";
          hash = "sha256-bgbMc4HqigqgdkvUe/CWbUclwxpl17ESLzCIP8Sz+F8=";
        };
      }
   ];
  };
}
