{ config, lib, ... } @ args:

{
  networking = {
    hostName = "zen";
    useDHCP = lib.mkDefault true;
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
    enableIPv6 = false; # disable ipv6
};

}
