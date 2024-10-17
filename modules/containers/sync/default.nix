{ config
, lib
, pkgs
, ...
}: {
  containers.sync = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.14";
    config =
      { config
      , pkgs
      , ...
      }: {
        services.etebase-server = {
          enable = true;

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
