{ pkgs, ... }:
{
  imports = [
    #./ssh.nix Need to be configured, but safety is important
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    # GUI apps
    #    firefox
    youtube-music
    foliate # do not support .pdf

    # Comunication
    thunderbird
    station # I need to upload

    telegram-desktop

    # remote desktop
    remmina

    # Audio
    wireplumber
    helvum
    noisetorch

    #Productivity
    teams-for-linux

    # Security
    bitwarden
  ];
}
