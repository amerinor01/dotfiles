{ pkgs, ... }:
{
  home.packages = with pkgs; [

    # archives
    zip
    xz
    unzip
    p7zip
    gnutar
    zstd

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    pandoc # file formater
    which # A binary finder
    tree # A director listing
    gnused # GNU sed, string editor
    gawk # A GNU awk
    nnn # terminal file manager
    glow # markdown previewer in terminal

    # Security   
    gnupg

    # Monitoring
    btop # Process
    lsof # Open file analysis
    sysstat # Performance monitoring tools
    lm_sensors # Tools for reading hardware sensors
    pciutils
    usbutils
    hdparm
    dmidecode
    file

    zellij # a terminal multiplexer
    nerdfonts # Fonts for everyone
    tldr
    nixfmt-rfc-style # A formatter for Nix code, intended to easily apply a uniform style. TODO: change to nixfmt when enable

    atuin
    skim
  ];

  #programs.skim = {
  # Fuzzy finder
  #  enable = true;
  #  enableBashIntegration = true;
  #};

  # programs.atuin = {
  #  enable = true;
  #};

}
