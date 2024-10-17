{ pkgs, ... }: {
  imports = [
    ./wayland-apps.nix
  ];

  home = {
    file = {
      # Folder that contains all Hyperland configuration
      ".config/hypr" = {
        source = ./hypr-conf;
        recursive = true;
      };

      # GTK2 Config
      ".gtkrc-2.0".source = ./gtkrc-2.0;

      #GTK3 Config
      ".config/gtk-3.0" = {
        source = ./gtk-3.0;
        recursive = true;
      };

      # Copy wallpaper to use by hypr config
      ".config/hypr/wallpapers/wallpaper.png".source = ./hypr-conf/wallpaper.png;
    };

    # set Xcursor.theme & Xcursor.size in ~/.Xresources automatically
    pointerCursor = {
      name = "Qogir-dark";
      package = pkgs.qogir-theme;
      size = 64;
      gtk.enable = true;
    };

  };

  # allow fontconfig to discover fonts and configurations installed through home.packages
  fonts.fontconfig.enable = true;

  systemd.user.sessionVariables = {
    "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
    "MOZ_ENABLE_WAYLAND" = "1"; # for firefox to run on wayland
    "MOZ_WEBRENDER" = "1";
  };

}
