{
  lib,
  pkgs,
  ...
}: 
{
  
  ###################################################################################
  #
  #  NixOS's core configuration suitable for all my machines
  #
  ###################################################################################

  # for nix server, we do not need to keep too much generations
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;
  # boot.loader.grub.configurationLimit = 10;
  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 1w";
  };

  # Manual optimise storage: nix-store --optimise
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  # enable flakes globally
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = lib.mkDefault true;

  # Set your time zone.
  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # TODO review if i need this config since i using hyprland
  # Configure keymap in X11
  services.xserver = {
    layout = "es";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "es";

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = lib.mkDefault false;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  #programs.ssh.extraConfig = builtins.readFile ./dotfiles/ssh/config;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git # used by nix flakes
    git-lfs # used by huggingface models
    bash
    zsh
    rar
  ];
  # replace default editor with neovim
  environment.variables.EDITOR = "nvim";
  
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;

  # for power management
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Enable zsh at system level
  programs.zsh.enable = true;
}
