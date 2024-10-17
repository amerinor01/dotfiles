{
  imports = [
    ./hardware-configuration.nix
    ../../modules/users.nix
    ../../modules/system-core.nix
    ../../modules/containers
    ../../modules/services/tailscale.nix
    ../../modules/services/adguard.nix
    ../../modules/emulation/binfmt.nix
    ../../modules/network.nix
    ../../modules/services/samba.nix
  ];
  
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
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
    # Use the GRUB 2 boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10; #Set the number of snapshots to max 10
    };
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking = {
    hostName = "server";
    enableIPv6 = false; # disable ipv6
    nameservers = [
      "1.1.1.1" # CLoudfare DNS 
      "9.9.9.9" # Quad9 DNS
    ];
  };
  system.stateVersion = "24.05";

}
