{
  pkgs,
  config,
  ...
}: {
  
  programs = {
    #autofirma.enable = true;
    #autofirma.firefoxIntegration.profiles = {
    #  amerino = {
    #    enable = true;
    #  };
    #};

    #autofirma-nix.dniremote.enable = true;

    #configuradorfnmt.enable = true;
    #configuradorfnmt.firefoxIntegration.profiles = {
    #  amerino = {
    #    enable = true;
    #  };
    #};

    firefox = {
      enable = true;
      enableGnomeExtensions = false;
      #policies = {
      #  SecurityDevices = {
      #"OpenSC PKCS11" = "${pkgs.opensc}/lib/opensc-pkcs11.so"; # Para poder utilizar el DNIe, y otras tarjetas inteligentes
      #"DNIeRemote" = "${config.programs.dnieremote.finalPackage}/lib/libdnieremotepkcs11.so"; # Para poder utilizar el DNIe por NFC desde un móvil Android
      #  };
      #};

      profiles.amerino = {
        id = 0;
      };
    };
  };
}
