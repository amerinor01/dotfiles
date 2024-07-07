# common-home-manager.nix
{ user, importPath, specialArgs }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = specialArgs;
  home-manager.users.${user} = import importPath;
}
