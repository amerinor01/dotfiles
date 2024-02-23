{
  config,
  lib,
  pkgs,
  ...
}: {
  containers.nginx = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.13";

    config = {
      config,
      pkgs,
      ...
    }: {
      services.nginx = {
        enable = true;

        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        # other Nginx options
        virtualHosts."jelly" = {
          locations."/" = {
            proxyPass = "http://192.168.100.12:8096";
          };
          locations."/sonarr" = {
            proxyPass = "http://192.168.100.12:8989";
          };
        };
        virtualHosts."sonarr" = {
          locations."/" = {
            proxyPass = "http://192.168.100.12:8989";
          };
        };
      };

      system.stateVersion = "23.11";

      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [
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
