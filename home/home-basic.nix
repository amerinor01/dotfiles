{self, ...}:
let name = "amerino";
in
{
  imports = [
    ./base
  ];

  home = {
    username = name;
    homeDirectory = "/home/${name}";
    stateVersion = "24.05";
  };
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
