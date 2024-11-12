{
  ...
}:
{

  services.caddy = {
    enable = true;
    virtualHosts."server".extraConfig = ''
      reverse_proxy localhost:8384
    '';
  };
}
