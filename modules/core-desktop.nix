{
  pkgs,
  ...
}:
{
  ###################################################################################
  #
  #  NixOS's core configuration suitable for my desktop computer
  #
  ###################################################################################

  imports = [
    ./system-core.nix
  ];

  # all fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
  fonts = {
    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome

      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra

      source-sans
      source-serif
      source-han-sans
      source-han-serif

      # nerdfonts
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
          "Iosevka"
          "Hack"
        ];
      })

      (pkgs.callPackage ../custom/icomoon-feather-icon-font.nix { })
    ];

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Color Emoji"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Noto Color Emoji"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  programs = {
    dconf.enable = true;
    ssh.startAgent = true;
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    # python, some times I may need to use python with root permission.
    (python310.withPackages (
      ps: with ps; [
        ipython
      ]
    ))
  ];

  # Disable pulseaudio, it conflicts with pipewire too.
  hardware.pulseaudio.enable = false;

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;
    # security with gnome-kering
    gnome.gnome-keyring.enable = true;
  };

  # security with polkit
  # rtkit is optional but recommended
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.greetd.enableGnomeKeyring = true;
  };
}
