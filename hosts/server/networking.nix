{ lib, ... }:
{
  networking = {
    hostName = "server";

    nameservers = [
      "1.1.1.1" # CLoudfare DNS
      "9.9.9.9" # Quad9 DNS
    ];

    useDHCP = lib.mkDefault true;
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
    enableIPv6 = false; # disable ipv6
  };

}
