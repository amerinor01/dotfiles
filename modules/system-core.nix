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
  nix = {
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 1w";
    };
    settings = {
      auto-optimise-store = true;
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git # used by nix flakes
    bash
    zsh
    rar
    searxng
    sddm-chili-theme
  ];
  # replace default editor with neovim
  environment.variables.EDITOR = "nvim";

  # Enable the OpenSSH daemon.
  services = {
    # for power management
    power-profiles-daemon.enable = true;
    upower.enable = true;

    openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no"; # disable root login
        PasswordAuthentication = true; # disable password login
      };
      openFirewall = false;
    };

    searx = {
      enable = true;
      settings = {
        server = {
          port = 8888;
          bind_address = "127.0.0.1";
          secret_key = "foo";
        };
      };
    };

  };

  # Enable zsh at system level
  programs.zsh.enable = true;

}
