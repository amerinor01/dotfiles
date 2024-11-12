{ self, ... }:
let
  name = "amerino";
in
{
  imports = [
    #    ./base
    ./desktop
    ./hyprland
    ./programs
  ];

  home = {
    username = name;
    homeDirectory = "/home/${name}";
    stateVersion = "24.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
