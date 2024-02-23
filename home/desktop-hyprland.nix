{...}: {
  imports = [
    ./base
    ./desktop
    ./hyprland
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = let
    name = "amerino";
  in {
    username = name;
    homeDirectory = "/home/${name}";
    stateVersion = "23.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
