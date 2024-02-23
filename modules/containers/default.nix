{pkgs, ...}: {
  imports = [
    #		./nginx
    #./streaming
    #./nextcloud
    ./vaultwarden
  ];

  networking.nat = {
    enable = true;
    internalInterfaces = ["ve-+"];
    externalInterface = "ens3";
  };

  virtualisation.docker.enable = true;
}
