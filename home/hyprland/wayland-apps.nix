{ pkgs
, config
, ...
}: {

  programs = {
    # Tool to signs documents in spain
#    autofirma = {
#      enable = true;

#      firefoxIntegration.profiles = {
#        amerino.enable = true;
#      };
#    };

    # Tool to update digital signs from spain
#    configuradorfnmt = {
#      enable = true;
#      firefoxIntegration.profiles = {
#        amerino.enable = true;
#      };
#    };

    # Enable firefox to use autofirma and DNI digital
    firefox = {
      enable = true;
      profiles = {
        amerino.id = 0;
      };

      enableGnomeExtensions = false;
      policies = {
        SecurityDevices = {
#          "OpenSC PKCS11" = "${pkgs.opensc}/lib/opensc-pkcs11.so"; # Para poder utilizar el DNIe, y otras tarjetas inteligentes
#          "DNIeRemote" = "${config.programs.dnieremote.finalPackage}/lib/libdnieremotepkcs11.so"; # Para poder utilizar el DNIe por NFC desde un móvil Android
        };
      };

    };
  };
}
