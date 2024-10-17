{ inputs
, pkgs
, ...
}: {

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    waybar # the status bar
    swaybg # the wallpaper
    swayidle # the idle timeout
    swaylock # locking the screen
    wlogout # logout menu
    wl-clipboard # copying and pasting

    # Screen recording and screenshot 
    wf-recorder # screen recording
    grim # taking screenshots
    slurp # selecting a region to screenshot
    sway-contrib.grimshot # a screenshot utility for sway

    wofi # A rofi inspired launcher for wlroots compositors such as sway/hyprland
    mako # the notification daemon, the same as dunst

    yad # a fork of zenity, for creating dialogs

    # audio
    alsa-utils # provides amixer/alsamixer/...

    mpd # for playing system sounds
    mpc-cli # command-line mpd client
    ncmpcpp # a mpd client with a UI
    networkmanagerapplet # provide GUI app: nm-connection-editor
    xfce.thunar # xfce4's file manager
    sddm-chili-theme
  ];

  programs = {
    hyprland.enable = true;
    # monitor backlight control
    light.enable = true;
    # This is part of the GUI programs! TODO remove this
    # thunar file manager(part of xfce) related options
    thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];

  };

  services = {
    xserver = {
      enable = true;

      desktopManager = {
        xterm.enable = false; #Set xterm as desktopManager (everything handle by hyperland)
      };
    };
    #For now I'm using this config to use hyprland. I wanna change to Sddm instead.
    displayManager = {
      defaultSession = "hyprland";
      sddm.enable = true;
      };
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images

    #displayManager = {
    #  defaultSession = "hyprland";
    #  
    #  sddm = {
    #    enable = true;
    #    wayland.enable = true;
    #  };
    #};

  };

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

}
