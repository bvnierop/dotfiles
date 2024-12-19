{
  description = "Home Manager configuration of bvnierop";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    stable.url = "github:nixos/nixpkgs/release-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    release-2305.url = "github:nixos/nixpkgs/release-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "stable";
    };

    # NixGL fixes OpenGL issues on non-NixOS systems.
    nixGL = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = { home-manager, nixGL, ... }@inputs:
    let
      system = "x86_64-linux";

      nixpkgConfig = {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        overlays = [ nixGL.overlay ];
      };

      pkgs = import inputs.nixpkgs nixpkgConfig;

      nixpkgs.for = {
      };

      nixpkgs.from = {
        stable = import inputs.stable nixpkgConfig;
        unstable = import inputs.unstable nixpkgConfig;
        release-2305 = import inputs.release-2305 nixpkgConfig;
      };
    in {
      homeConfigurations."bvnierop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = { inherit nixpkgs; };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          ({ ... }: {
            nixGLPrefix =
              "${nixGL.packages.x86_64-linux.nixGLIntel}/bin/nixGLIntel ";
          })
        ];
      };
    };
}
