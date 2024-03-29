{ config, ... } @ args:

#############################################################
#
#  Laptop - my dayly driver, with NixOS
#
#############################################################

{
  imports = [
    ./hardware-configuration.nix
    
    ../../modules/users.nix
    ../../modules/containers
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

  networking = {
    hostName = "server";
    wireless.enable = false; # Enables wireless support via wpa_supplicant.

    networkmanager.enable = true;

    enableIPv6 = false; # disable ipv6
};

  system.stateVersion = "23.05";

}
