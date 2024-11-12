{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix

    ../../modules/users.nix
    ../../modules/system-core.nix
    ../../modules/containers
    ../../modules/services/tailscale.nix
    ../../modules/services/adguard.nix
    ../../modules/emulation/binfmt.nix
    ../../modules/network.nix
    ../../modules/services/samba.nix
    ../../modules/firefox.nix
    ../../modules/hyprland.nix # Require have Host add as a module on the flake!!
    ../../modules/hosts.nix # Require have Host add as a module on the flake!!
    ../../modules/services/searx.nix
    ../../modules/services/ssh.nix

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
      systemd-boot.configurationLimit = 10; # Set the number of snapshots to max 10
    };
  };
}
