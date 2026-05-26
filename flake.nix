{
  description = "Home Manager module for stow-style dotfiles";

  outputs = { ... }:
    let
      dotfilesModule = import ./module.nix;
    in
    {
      homeManagerModules.default = dotfilesModule;
      homeManagerModules.dotfiles = dotfilesModule;
    };
}
