{
  description = "My Nix Home";

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # Default nixos-stable packages
    nixpkgs.url = "nixpkgs/nixos-24.05";

    # Also add the Nixpkgs unstable for some updated packages
    #nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # Set the hardware configurations
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Home manager set the configuration for the users
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO Set secrets management for the future
    # sops-nix.url = "github:Mic92/sops-nix";

    #File to block most of the stuff avoidable online
    hosts.url = "github:StevenBlack/hosts";

    autofirma-nix = {
      url = "github:nilp0inter/autofirma-nix/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:elythh/nixvim";
    screenpad-driver = {
      url = "github:MatthewCash/asus-wmi-screenpad-module";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      hosts,
      autofirma-nix,
      nixos-hardware,
      ...
    }:
    let
      commonHomeManager =
        {
          user,
          importPath,
        }:
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.${user} = import importPath;
          };
        };

      x64_system = "x86_64-linux";
      x64_specialArgs = {
        # Use the unstable channel for some packages
        pkgs-unstable = import inputs.nixpkgs-unstable {
          system = x64_system;
          config.allowUnfree = true;
        };

      } // inputs;

      server_modules = [
        hosts.nixosModule
        home-manager.nixosModules.home-manager
        #autofirma-nix.nixosModules.default
        #sops-nix.nixosModules.sops

        ./hosts/server
        #./modules/autofirma.nix

        #Home Manager config
        (commonHomeManager {
          user = "amerino";
          importPath = ./home/desktop-hyprland.nix;
          # specialArgs = x64_specialArgs;
        })
      ];

      zen_modules = [
        ./hosts/zen
        ./modules/hyprland.nix

        autofirma-nix.nixosModules
        ./modules/autofirma.nix
        nixos-hardware.nixosModules.Asus-Zenbook-Pro-15-UX535
        #sops-nix.nixosModules.sops
        hosts.nixosModule
        {
          networking.stevenBlackHosts.enable = true;
        }
        #Home Manager config
        home-manager.nixosModules.home-manager
        (commonHomeManager {
          user = "amerino";
          importPath = ./home/desktop-hyprland.nix;
          #  specialArgs = x64_specialArgs;
        })

      ];
    in
    {
      nixosConfigurations =
        let
          system = x64_system;
          specialArgs = x64_specialArgs;
        in
        {
          server = nixpkgs.lib.nixosSystem {
            inherit system specialArgs;
            modules = server_modules;
          };
          zen = nixpkgs.lib.nixosSystem {
            inherit system specialArgs;
            modules = zen_modules;
          };

        };
    };
}
