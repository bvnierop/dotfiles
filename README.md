Required software
=================

Macintosh
---------
- `brew install reattach-to-user-namespace` is required for copy/pasting in tmux


Linux
---------
Emacs config uses Chemacs and Doom Emacs

Doom Emacs needs to be installed in ~/doom-emacs


Nix flake Home Manager module
=============================

This repository exposes a Home Manager module from `flake.nix`.
The stow-style config root is `config/`; each immediate directory inside it is a selectable config package, and paths inside each package are linked relative to `$HOME`.

Example consumer flake usage:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    dotfiles.url = "github:USER/dotfiles";
  };

  outputs = { nixpkgs, home-manager, dotfiles, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations.me = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          dotfiles.homeManagerModules.default
          {
            home.dotfiles.enable = true;

            # Optional: install only selected config packages.
            # If omitted or empty, all directories under config/ are installed.
            home.dotfiles.programs = [ "bash" "git" ];

            # Optional: make linked files editable in-place by linking back to
            # this checkout instead of to immutable Nix store copies.
            # Use an absolute string path, not a Nix path literal like ./.
            home.dotfiles.makeSymbolicLinks = true;
            home.dotfiles.checkoutPath = "/home/me/repositories/dotfiles";
          }
        ];
      };
    };
}
```

Add an empty `.noflake` file to any directory under `config/` to exclude that directory and its subtree from flake-managed installation.
