{ config, pkgs, lib, nixvim, ... }:

{
  imports = [
    ./i3.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "isaac";
  home.homeDirectory = "/home/isaac";
  home.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      vi = "nvim";
      ll = "ls -la";
      nixupdate = "sudo nixos-rebuild switch --flake '/home/isaac/.config/nix/#MonixOS'";
      homeupdate = "home-manager switch --flake /home/isaac/.config/nix/src/#isaac";
      monika = "steam-run ~/ddlc/DDLC.sh";
      pollymc = "appimage-run ~/PollyMC-Linux-7.2-x86_64.AppImage";
      untargz = "tar -xvzf";
      untar = "tar -xvf";
      sudonv = "sudo -E -s nvim";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
      ];
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "candy";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.85;
      shell.program = "/home/isaac/.nix-profile/bin/zsh";
      use_thin_strokes = false;
      #cursor.style = "Beam";

      window = {
        decorations = "None";
      };
      font = {
        size = 10;
        normal.family = "JetBrainsMonoNerdFont";
        bold.family = "JetBrainsMonoNerdFont";
        italic.family = "JetBrainsMonoNerdFont";
      };

      colors = {
        primary = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
        };

        normal = {
          black = "#45475A";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#89B4FA";
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#BAC2DE";
        };

        bright = {
          black = "#585B70";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#EED49F";
          blue = "#89BAFA";
          magenta = "#F5C2E7";
          cyan = "#94D2D5";
          white = "#A6ADC8";
        };
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Isc740";
    userEmail = "isaazcantillo@gmail.com"; 
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      yzhang.markdown-all-in-one
      jnoortheen.nix-ide
      llvm-vs-code-extensions.vscode-clangd
      ms-python.python
      pkief.material-icon-theme

    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "remote-ssh-edit";
        publisher = "ms-vscode-remote";
        version = "0.47.2";
        sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      }

      # {
      #   name = "nebula-oni-theme";
      #   publisher = "psudo-dev";
      #   version = "2.0.3";
      # 	sha256 = "ygV1a4XpaFfoFI82cJsIZlEak0e87qBUNF766ofp2Mo";
      # }
    ];
  };


  home.packages = with pkgs; [
    #Gnome Extensions
    gnome3.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.compiz-windows-effect

    pulsemixer
    dmenu
    i3lock-fancy
    spotify
    steamcmd
    tutanota-desktop
    whatsapp-for-linux
    #libsForQt5.kxmlgui
    qt5.qtbase
    gimp-with-plugins
    neovim
    onlyoffice-bin
    gnome-browser-connector
    firefox
    neofetch
    htop
    xwayland
    rofi
    dmenu
    gnome3.gnome-tweaks
    gparted
    appimage-run
    wl-clipboard
    xclip
    xautoclick

    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })

    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })


    # You can also create simple shell scripts directly inside your
    (pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
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
  #  /etc/profiles/per-user/isaac/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
