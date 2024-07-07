{
  pkgs,
  config,
  ...
}:
# processing audio/video
{
  home.packages = with pkgs; [
    ffmpeg-full

    # images
    viu # Terminal image viewer with native support for iTerm and Kitty
    imagemagick
    graphviz
    #imv # simple image viewer

    # video
    #ivlc

    # audio control
    #pavucontrol
    #playerctl
    #pulsemixer
  ];

  #programs = {
  #  mpv = {
  #    enable = true;
  #    defaultProfiles = ["gpu-hq"];
  #    scripts = [pkgs.mpvScripts.mpris];
  #  };
  #};

  #services = {
  #  playerctld.enable = true;
  #};
}
