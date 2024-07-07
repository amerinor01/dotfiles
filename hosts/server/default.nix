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
    ../../modules/system-core.nix
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
 
# Enable binfmt emulation.
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];
    
  #Set the number of snapshots to max 10
  boot.loader.systemd-boot.configurationLimit = 10;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking = {
    hostName = "server";
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    enableIPv6 = false; # disable ipv6
};

  system.stateVersion = "24.05";

}
