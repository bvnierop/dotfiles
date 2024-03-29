{ config, pkgs, lib, ... }:

let nixGL = import ./nixGL.nix { inherit pkgs config; };
in {
  imports = [
    ./options.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bvnierop";
  home.homeDirectory = "/home/bvnierop";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.ripgrep
    pkgs.silver-searcher

    pkgs.asdf-vm

    pkgs.awscli2
    pkgs.nodePackages.aws-cdk

    # dotnet
    # (with pkgs.dotnetCorePackages; combinePackages [
    #     sdk_7_0
    # 	sdk_6_0
    # ])
    pkgs.omnisharp-roslyn

    # git
    pkgs.git-crypt

    # For copy/paste
    pkgs.xclip

    pkgs.tree

    (nixGL pkgs.ungoogled-chromium)

    # Required for Zwijsen
    pkgs.nodejs-16_x
    pkgs.yarn

	# terminal file managers
    pkgs.mc
    pkgs.lf

    # Util
    pkgs.mlocate

    # Spotify
    pkgs.spotify
    pkgs.spotify-tui
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/bvnierop/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable starship
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$nix_shell"
        "$line_break"
        "$time"
        "$character"
      ];
      character = {
        success_symbol = "[\\$](green)";
        error_symbol = "[\\$](red)";
        vicmd_symbol = "[\\$](green)";
      };
      directory = {
        fish_style_pwd_dir_length = 1;
      };
      time = {
        disabled = false;
        format = "[$time]($style)";
        style = "dimmed grey";
      };
      username = {
        show_always = true;
        format = "[$user]($style)";
        style_user = "bold dimmed green";
      };
      hostname = {
        ssh_only = false;
        format = "[@$hostname]($style):";
      };
    };
  };

  # Enable fzf
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  # Enable qutebrowser
  programs.qutebrowser = {
    enable = true;
    package = (nixGL pkgs.qutebrowser);
  };

}
