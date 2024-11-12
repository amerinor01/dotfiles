{ ... }:

#############################################################
#
#  Zen - my dayly driver, with NixOS
#
#############################################################

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ../../modules/services/tailscale.nix
    ../../modules/fhs-fonts.nix
    ../../modules/core-desktop.nix
    ../../modules/users.nix
  ];

  boot = {
    supportedFilesystems = [
      "ext4"
      "btrfs"
      "xfs"
      "ntfs"
      "fat"
      "vfat"
      "exfat"
      "cifs" # mount windows share
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };
  };
}
