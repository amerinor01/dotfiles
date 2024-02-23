{
  inputs,
  pkgs,
  ...
}: {
  ##########################################################################################################
  #
  #  NixOS's Configuration for Hyprland Window Manager
  #
  ##########################################################################################################

  environment.pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.desktopManager.gnome.enable = true;
}
