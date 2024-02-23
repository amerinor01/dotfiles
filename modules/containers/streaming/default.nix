{
  config,
  lib,
  pkgs,
  ...
}: {
  # Make sure to have nginx enabled
  services.nginx.enable = true;
  services.nginx.virtualHosts.${config.networking.hostName}.locations = let
    onlyLan = ''
      allow 100.0.0.0/8;
      allow 127.0.0.1/24;
      deny all;
    '';
  in {
    # Index file
    "/" = {
      root = pkgs.writeTextDir "index.html" ''
        <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="utf-8" />
            <title>Links</title>
          </head>
          <body>
            <ul>
              <li><a href="/bazarr">Bazarr (Subtitles)</a></li>
              <li><a href="/sonarr">Sonarr (Series)</a></li>
              <li><a href="/radarr">Radarr (Movies)</a></li>
              <li><a href="/lidarr">Lidarr (Music)</a></li>
              <li><a href="/jellyfin">jellyfin</a></li>
            </ul>
          </body>
        </html>
      '';
      extraConfig = onlyLan;
    };
    "/bazarr" = {
      proxyPass = "http://127.0.0.1:6767/bazarr";
      extraConfig = onlyLan;
    };
    "/sonarr" = {
      proxyPass = "http://127.0.0.1:8989/sonarr";
      extraConfig = onlyLan;
    };
    "/radarr" = {
      proxyPass = "http://127.0.0.1:7878/radarr";
      extraConfig = onlyLan;
    };
    "/lidarr" = {
      proxyPass = "http://127.0.0.1:8686/lidarr";
      extraConfig = onlyLan;
    };
    "/jellyfin" = {
      proxyPass = "http://127.0.0.1:8096/jellyfin";
      extraConfig = onlyLan;
    };
  };

# Content container.
containers.jellyfin = {
  autoStart = true;
  #privateNetwork = true;
  #hostAddress = "192.168.100.10";
  #localAddress = "192.168.100.12";
  #bindMounts."/home" = { 
  #  hostPath = "/home/amerino/";
  #  isReadOnly = false; 
  #};
  
  config = { config, pkgs, ... }: {

      # 1. enable vaapi on OS-level
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
    
    system.stateVersion = "23.11";

    networking = {
      firewall = {
        enable = true;
        allowedTCPPorts = [ 
        8096 # jellyfin port
        6767 # bazarr port
        8686 # lidarr port 
        8989 # sonar port
        7878 # radarr port
        9696 # prowlarr port
        8787 # readarr port
        80
        ];
      };
      # Use systemd-resolved inside the container
      # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
      useHostResolvConf = false;
    };
    
    services.resolved.enable = true;

  };
};

}
