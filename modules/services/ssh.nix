{
  # Enable the OpenSSH daemon.
  services = {
    openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no"; # disable root login
        PasswordAuthentication = true; # disable password login
      };
      openFirewall = false;
    };

  };
}
