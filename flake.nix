{
  description = "My Nix Home";

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # Default nixos-unstable packages
    nixpkgs.url = "nixpkgs/nixos-23.05";

    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # Set the hardware configurations
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Home manager set the configuration for the users
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # community wayland nixpkgs
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    # Prettier formatter for nix
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    #Autofirma flakes
    autofirma-nix = {
      url = "github:nilp0inter/autofirma-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO Set secrets management for the future
    #agenix.url = "github:ryantm/agenix/0d8c5325fc81daf00532e3e26c6752f7bcde1143";
    #mysecrets = { url = "git+ssh://git@github.com/ryan4yin/nix-secrets.git?shallow=1"; flake = false; };
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    alejandra,
    autofirma-nix,
    ...
  }: let
    x64_system = "x86_64-linux";
    x64_specialArgs =
      {
       # Use the unstable channel for some packages
#        pkgs-unstable = import inputs.nixpkgs-unstable {
#          system = x64_system;
#          config.allowUnfree = true;
#        };
      }
      // inputs;
    # Set the laptop configuration
    laptop_modules = [
      ./hosts/laptop
      ./modules/hyprland.nix
      ./modules/containers

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.extraSpecialArgs = x64_specialArgs ;
        home-manager.users.amerino = import ./home/desktop-hyprland.nix;
      }
      {
        environment.systemPackages = [alejandra.defaultPackage.${x64_system}];
      }
    ];
  server_modules = [
	./host/server
    
	home-manager.nixosModules.home-manager{
	  home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "backup";
    home-manager.extraSpecialArgs = x64_specialArgs;
    home-manager.users.amerino = import ./home/desktop-basic.nix;
	}
    ];


  in {
    nixosConfigurations = let
      system = x64_system;
      specialArgs = x64_specialArgs;
    in {
      laptop = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
        autofirma-nix.homeManagerModules.default
        laptop_modules
         ];
    };
      server = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = server_modules;
      };
      };
  };
}
