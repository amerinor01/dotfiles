{ config, ... } @ args:

#############################################################
#
#  Laptop - my dayly driver, with NixOS
#
#############################################################

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    
    ../../modules/fhs-fonts.nix
    ../../modules/libvirt.nix
    ../../modules/core-desktop.nix
    ../../modules/users.nix
  ];

    boot.supportedFilesystems = [
    "ext4"
    "btrfs"
    "xfs"
    #"zfs"
    "ntfs"
    "fat"
    "vfat"
    "exfat"
    "cifs" # mount windows share
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #Set the number of snapshots to max 10
  boot.loader.systemd-boot.configurationLimit = 10;
  
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-23.11";
  system.stateVersion = "23.11";

}
