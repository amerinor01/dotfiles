{pkgs, ...}: {
  home.packages = with pkgs; [
    nix-output-monitor # Processes output of Nix commands to show helpful and pretty information
    nodePackages.node2nix # Generate Nix expressions to build NPM packages
  ];
}
