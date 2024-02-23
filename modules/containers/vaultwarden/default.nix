{
  config,
  lib,
  pkgs,
  ...
}: {
  containers.vaultwarden = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.14";
    config = {
      config,
      pkgs,
      ...
    }: {
      services.vaultwarden = {
        enable = true;
        backupDir = "/mnt/bitwarden";
        config = {
          WEB_VAULT_FOLDER = "${pkgs.vaultwarden.webvault}/share/vaultwarden/vault";
          WEB_VAULT_ENABLED = true;
          #LOG_FILE = "/var/log/bitwarden";
          WEBSOCKET_ENABLED = true;
          WEBSOCKET_ADDRESS = "0.0.0.0";
          WEBSOCKET_PORT = 3012;
          SIGNUPS_VERIFY = true;
          #    ADMIN_TOKEN = (import /etc/nixos/secret/bitwarden.nix).ADMIN_TOKEN;
          DOMAIN = "https://exmaple.com";
          #    YUBICO_CLIENT_ID = (import /etc/nixos/secret/bitwarden.nix).YUBICO_CLIENT_ID;
          #    YUBICO_SECRET_KEY = (import /etc/nixos/secret/bitwarden.nix).YUBICO_SECRET_KEY;
          YUBICO_SERVER = "https://api.yubico.com/wsapi/2.0/verify";
          SMTP_HOST = "mx.example.com";
          SMTP_FROM = "bitwarden@example.com";
          SMTP_FROM_NAME = "Bitwarden_RS";
          #SMTP_PORT = 587; # Deprecated
          #SMTP_SSL = true;
          #     SMTP_USERNAME = (import /etc/nixos/secret/bitwarden.nix).SMTP_USERNAME;
          #     SMTP_PASSWORD = (import /etc/nixos/secret/bitwarden.nix).SMTP_PASSWORD;
          SMTP_TIMEOUT = 15;
          ROCKET_PORT = 8812;
        };
        #environmentFile = "/etc/nixos/secret/bitwarden.env";
      };

      services.nginx = {
        enable = true;

        recommendedProxySettings = true;

        virtualHosts = {
          "vaulwarden.containers" = {
            locations."/" = {
              proxyPass = "http://localhost:8812";
              proxyWebsockets = true;
            };
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
