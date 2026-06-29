{ config, lib, ... }:
let
  cfg = config.home.dotfiles;
  configRoot = ./config;
  configRootEntries = builtins.readDir configRoot;

  availablePrograms =
    builtins.sort builtins.lessThan
      (builtins.filter
        (name:
          configRootEntries.${name} == "directory"
          && builtins.substring 0 1 name != ".")
        (builtins.attrNames configRootEntries));

  selectedPrograms =
    if cfg.programs == [ ] then availablePrograms else cfg.programs;

  invalidPrograms =
    builtins.filter
      (program: !(builtins.elem program availablePrograms))
      selectedPrograms;

  validSelectedPrograms =
    builtins.filter
      (program: builtins.elem program availablePrograms)
      selectedPrograms;

  mkSource = program: target: storeSource:
    if cfg.makeSymbolicLinks && cfg.checkoutPath != null then
      config.lib.file.mkOutOfStoreSymlink
        "${cfg.checkoutPath}/config/${program}/${target}"
    else
      storeSource;

  collectFiles = program: dir: prefix:
    let
      entries = builtins.readDir dir;
      names = builtins.attrNames entries;
      hasNoFlakeMarker = entries ? ".noflake" && entries.".noflake" == "regular";
    in
    if hasNoFlakeMarker then
      [ ]
    else
      lib.concatLists (map
        (name:
          let
            entryType = entries.${name};
            source = dir + "/${name}";
            target = if prefix == "" then name else "${prefix}/${name}";
          in
          if name == ".noflake" then [ ]
          else if entryType == "directory" then collectFiles program source target
          else if entryType == "regular" then [
            {
              name = target;
              value = {
                source = mkSource program target source;
              };
            }
          ]
          else [ ])
        names);

  collectProgramFiles = program:
    collectFiles program (configRoot + "/${program}") "";

  fileEntries =
    lib.concatLists (map collectProgramFiles validSelectedPrograms);

  fileTargets = map (entry: entry.name) fileEntries;

  targetCounts =
    builtins.foldl'
      (counts: target:
        counts // {
          ${target} = (counts.${target} or 0) + 1;
        })
      { }
      fileTargets;

  duplicateTargets =
    builtins.filter
      (target: targetCounts.${target} > 1)
      (lib.unique fileTargets);
in
{
  options.home.dotfiles = {
    enable = lib.mkEnableOption "installation of this repository's dotfiles";

    makeSymbolicLinks = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = ''
        Whether to create out-of-store symbolic links back to this repository
        checkout instead of linking immutable Nix store copies.

        When enabled, each file source uses Home Manager's
        `mkOutOfStoreSymlink` and points back to `home.dotfiles.checkoutPath`.
        This makes files editable through `$HOME`, but generations no longer
        pin file contents.
      '';
    };

    checkoutPath = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = lib.literalExpression ''"''${config.home.homeDirectory}/repositories/dotfiles"'';
      description = ''
        Absolute string path to this repository checkout.

        Required when `home.dotfiles.makeSymbolicLinks` is enabled. Use a
        string path, not a Nix path literal, so the checkout itself is not
        copied into the Nix store.
      '';
    };

    programs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [
        "bash"
        "git"
      ];
      description = ''
        Program directories under the dotfiles config root to install.

        When empty, all immediate directories under config/ are installed.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = invalidPrograms == [ ];
        message = ''
          home.dotfiles.programs contains unknown program(s): ${lib.concatStringsSep ", " invalidPrograms}.
          Available programs: ${lib.concatStringsSep ", " availablePrograms}
        '';
      }
      {
        assertion = !cfg.makeSymbolicLinks || (cfg.checkoutPath != null && builtins.substring 0 1 cfg.checkoutPath == "/");
        message = ''
          home.dotfiles.checkoutPath must be set to an absolute string path when
          home.dotfiles.makeSymbolicLinks is enabled.
        '';
      }
      {
        assertion = duplicateTargets == [ ];
        message = ''
          Multiple selected dotfile programs provide the same target path(s): ${lib.concatStringsSep ", " duplicateTargets}.
        '';
      }
    ];

    home.file =
      if duplicateTargets == [ ]
      then builtins.listToAttrs fileEntries
      else { };
  };
}
