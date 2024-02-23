{pkgs, ...}: {
  imports = [
    #./ssh.nix Need to be configured, but safety is important
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    # GUI apps
    firefox
    youtube-music

    # e-book
    foliate # do not support .pdf

    # Comunication
    thunderbird
    station # I need to upload
    teams
    telegram-desktop

    # remote desktop
    anydesk
 #   rustdesk

    # Audio
    wireplumber
    helvum
    noisetorch

    # Cli apps
    tldr
    exa
    killall
    
    #Productivity
    logseq
    emacs
    teams-for-linux   
    # Security
    bitwarden
  ];
}
