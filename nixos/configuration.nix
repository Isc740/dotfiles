# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];


  ###------BOOTLOADER------###
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  ###------PERSONAL------###
  networking.hostName = "MonixOS";
  time.timeZone = "America/Bogota";


  ###------ALLOW------###
  nixpkgs.config.allowUnfree = true;
  nix.settings.allowed-users = [ "*" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  ###------ENVIROMENT PATH------###

  environment.pathsToLink = [ "/libexec" ];

  ###------NETWORK------###
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  ###------XORG------### 
  services.xserver.enable = true;


  ###------LOCALE------###
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADRESS = "es_CO.UTF-8";
    LC_IDENTIFICATION = "es_CO.UTF-8";
    LC_MEASUREMENT = "es_CO.UTF-8";
    LC_MONETARY = "es_CO.UTF-8";
    LC_NAME = "es_CO.UTF-8";
    LC_NUMERIC = "es_CO.UTF-8";
    LC_PAPER = "es_CO.UTF-8";
    LC_TELEPHONE = "es_CO.UTF-8";
    LC_TIME = "es_CO.UTF-8";
  };



  ###------DESKTOP ENVIROMENTS------###
  services.xserver.desktopManager = {
    xterm.enable = false;
    xfce.enable = true;
    gnome.enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    gnome-characters
    cheese # webcam tool
    gnome-music
    gnome-terminal
    epiphany # web browser
    evince # document viewer
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.autoSuspend = false;
  security.polkit.extraConfig = ''
        polkit.addRule(function(action,subject) {
        if (action.id == "org.freedesktop.login1.suspend" ||
            action.id == "org.freedesktop.login1.suspend-multiple-sessions" ||
    	      action.id == "org.freedesktop.login1.hibernate" ||
    	      action.id == "org.freedesktop.login1.hibernate-multiple-sessions")
            {
             return polkit.Result.NO;
            }
         });
  '';


  ###------SUSPEND------###
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;


  ###------KEYBOARD------###
  services.xserver.layout = "us";
  #services.xserver.xkbVariant = "intl_deadkeys";
  #services.xserver.xkbOptions = "eurosign:e,caps:escape";


  ###------FONTS------###
  fonts.fontDir.enable = true;
  fonts.fontconfig.defaultFonts.monospace = [ "Iosevka" ];
  fonts.enableGhostscriptFonts = true;

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    corefonts
    mplus-outline-fonts.githubRelease
    iosevka
  ];


  ###------SOUND------###
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  ###------USERS------###
  users.users.isaac = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [

    ];
  };


  ###------SYSPKGS------###
  environment.systemPackages = with pkgs; [
    rust-analyzer
    vscode-extensions.rust-analyzer
    direnv
    gnumake
    gcc
    ranger
    pamixer
    python3
    jdk17
    jdk8
    nodejs_20
    clang-tools
    unzip
    wget
  ];


  ###------PROGRAMS------###
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}