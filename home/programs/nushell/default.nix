{...}: {
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;

    # home-manager will merge the cotent in `environmentVariables` with the `envFile.source`
    # but basically, I set all environment variables via the shell-independent way, so I don't need to use those two options
    #
    # envFile.source = ./env.nu;
    # environmentVariables = { FOO="bar"; };
  };
}
