{ config, ... } @ args:

{

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nouveau"];

  networking = {
    hostName = "laptop";
    
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
    enableIPv6 = false; # disable ipv6
};

}
