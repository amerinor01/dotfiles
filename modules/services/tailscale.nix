{ lib
, pkgs
, ...
}:
{
  # Enable the OpenSSH daemon.
  services = {
    tailscale.enable = true;
    # for power management
  };

}
