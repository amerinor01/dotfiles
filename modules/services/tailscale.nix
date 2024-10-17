{ lib
, pkgs
, ...
}:
{
  services = {
    tailscale.enable = true;

    gitlab-runner.enable = true;
  };

}
