{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mtr # A network diagnostic tool
    iperf3 # A tool to measure IP bandwidth using UDP or TCP
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses
    ethtool # Controlling network drivers and hardware
  ];
}
