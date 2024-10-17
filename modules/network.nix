{
  networking = {
    enableIPv6 = false; # disable ipv6
    nameservers = [
      # TODO Set here personal DNS first
      "1.1.1.1" # CLoudfare DNS 
      "9.9.9.9" # Quad9 DNS
    ];
    firewall.enable = false;
  };
}
