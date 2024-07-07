{
  lib,
  pkgs,
  ...
}: {
  ###################################################################################
  #
  #  NixOS's core configuration suitable for my desktop computer
  #
  ###################################################################################

  imports = [
    ./system-core.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # all fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
  fonts = {
    # use fonts specified by user rather than default ones
    enableDefaultFonts = false;
    fontDir.enable = true;

    fonts = with pkgs; [
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

      (pkgs.callPackage ../custom/icomoon-feather-icon-font.nix {})
    ];

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  # dconf is a low-level configuration system.
  programs.dconf.enable = true;

  networking.firewall.enable = false;

  # The OpenSSH agent remembers private keys for you
  # so that you don’t have to type in passphrases every time you make an SSH connection.
  # Use `ssh-add` to add a key to the agent.
  programs.ssh.startAgent = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    # python, some times I may need to use python with root permission.
    (python310.withPackages (ps:
      with ps; [
        ipython
      ]))
  ];

  ;
  # rtkit is optional but recommended
  security.rtkit.enable = true;

  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  sound.enable = false;
  # Disable pulseaudio, it conflicts with pipewire too.
  hardware.pulseaudio.enable = false;

  # security with polkit
  services.power-profiles-daemon = {
    enable = true;
  };

  security.polkit.enable = true;
  # security with gnome-kering
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
}
