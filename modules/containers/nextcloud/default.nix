{
  config,
  lib,
  pkgs,
  ...
}: {

containers.nextcloud = {
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.10";
  localAddress = "192.168.100.11";
  config = { config, pkgs, ... }: {
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud27;
      hostName = "localhost";
      config.adminpassFile = "${pkgs.writeText "adminpass" "test123"}"; # DON'T DO THIS IN PRODUCTION - the password file will be world-readable in the Nix Store!
    };

    system.stateVersion = "23.11";

    networking = {
      firewall = {
        enable = true;
        allowedTCPPorts = [ 80 ];
      };
      # Use systemd-resolved inside the container
      # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
      useHostResolvConf = false;
    };
    
    services.resolved.enable = true;

  };
};
}
