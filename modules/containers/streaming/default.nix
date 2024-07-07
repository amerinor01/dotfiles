{
  config,
  lib,
  pkgs,
  ...
}: {      # 1. enable vaapi on OS-level
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };
    
    hardware.opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      ];
    };
    
    # jellyfin is a service to see your media.
    services.jellyfin = { 
      enable = true;
    };
    services.radarr = {
        enable = true;
    };
    services.bazarr = {
        enable = true;
    };
    services.sonarr = {
        enable = true;
    };
    services.lidarr = {
        enable = true;
    };
    services.prowlarr = {
        enable = true;
    };
    services.readarr = {
        enable = true;
    };
    services.transmission = {
        enable = true;
    };

    services.jackett = {
        enable = true;
    };
}
