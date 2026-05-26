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

  collectFiles = dir: prefix:
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
          else if entryType == "directory" then collectFiles source target
          else if entryType == "regular" then [
            {
              name = target;
              value = {
                inherit source;
              };
            }
          ]
          else [ ])
        names);

  collectProgramFiles = program:
    collectFiles (configRoot + "/${program}") "";

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
