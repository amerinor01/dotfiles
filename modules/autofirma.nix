{ pkgs, config, ... }:
{

  programs = {
    autofirma = {
      enable = true;
      fixJavaCerts = true;
      firefoxIntegration.enable = true;
    };

    dnieremote.enable = true;

    configuradorfnmt.enable = true;
    configuradorfnmt.firefoxIntegration.enable = true; # Para que Firefox utilice el Configurador FNMT

    firefox = {
      policies = {
        SecurityDevices = {
          "OpenSC PKCS#11" = "${pkgs.opensc}/lib/opensc-pkcs11.so"; # Para poder utilizar el DNIe, y otras tarjetas inteligentes
          "DNIeRemote" = "${config.programs.dnieremote.finalPackage}/lib/libdnieremotepkcs11.so"; # Para poder utilizar el DNIe por NFC desde un móvil Android
        };

      };

    };
  };
}
