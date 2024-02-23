{pkgs, ...}: {
  imports = [
    ./wayland-apps.nix
  ];

  # Only available on home-manager's master branch(2023/7/25)
  # wayland.windowManager.hyprland = {
  #   enable = true;
  # };

  # hyprland configs, based on https://github.com/notwidow/hyprland
  home.file.".config/hypr" = {
    source = ./hypr-conf;
    # copy the scripts directory recursively
    recursive = true;
  };
  home.file.".config/gtk-3.0" = {
    source = ./gtk-3.0;
    recursive = true;
  };
  home.file.".gtkrc-2.0".source = ./gtkrc-2.0;
  home.file.".config/hypr/wallpapers/wallpaper.png".source = ./hypr-conf/wallpaper.png;

  # allow fontconfig to discover fonts and configurations installed through home.packages
  fonts.fontconfig.enable = true;

  systemd.user.sessionVariables = {
    "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
    "MOZ_ENABLE_WAYLAND" = "1"; # for firefox to run on wayland
    "MOZ_WEBRENDER" = "1";
  };

  # set Xcursor.theme & Xcursor.size in ~/.Xresources automatically
  home.pointerCursor = {
    name = "Qogir-dark";
    package = pkgs.qogir-theme;
    size = 64;
    gtk.enable = true;
  };
}
