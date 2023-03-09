# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
## First Install
## use --option substituers 科大源

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Nixpkgs binary cache
  # tuna
  #nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  # USTC 科大源
  nix.settings.substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  networking.proxy.default = "http://192.168.5.1:7890/";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  i18n.defaultLocale = "zh_CN.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # font
  fonts.fonts = with pkgs; [
  	sarasa-gothic
	(nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ];})
  ];

  # sudoers extraConfig
  # sudo 免密
  security.sudo.extraConfig = "yang ALL=(ALL:ALL) NOPASSWD: ALL"; 

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # auto optimising the store 自动优化store
  nix.settings.auto-optimise-store = true;

  # garbage collection
  nix.gc= {
  	automatic = true;
	dates = "weekly";
	options = "--delete-older-than 30d";
  };

  # input method
  i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
	      fcitx5-gtk
	      fcitx5-chinese-addons
      ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yang= {
    isNormalUser = true;
    password = "jkl;";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      #firefox
      #thunderbird
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # basic
    libgccjit				                                # C
    rustup				                                  # rust
    wget				                                    # wget
    git					                                    # git
    lazygit				                                  # git gui
    python311				                                # python
    python311Packages.pip		                        # pip
    nodejs-19_x				                              # nodejs
    neofetch				                                # neofetch
    btop				                                    # btop
    bash-completion			                            # bash-completions
    nix-bash-completions		                        # bash-completions for nix
    tldr				                                    # alternative to man
    # terminal & shell
    starship				                                # starship 
    fish				                                    # fish shell
    alacritty				                                # terminal : alacritty
    kitty                                           # terminal : kitty
    zellij                                          # Terminal Multiplexer written in rust
    # screen shot
    flameshot				                                
    # editor
    neovim 				                                  # nvim
    vscode				                                  # vscode
    micro                                           # micro
    # web browser
    firefox				                                  # firefox
    # IDE
    jetbrains.pycharm-community		                  # python IDE
    jetbrains.idea-community                        # IDEA
    # DBmanager
    dbeaver				                                  # DataBase management
    # KDE plasma software
    libsForQt5.ark			                            # KED plasma : ark
    # video
    mpv					                                    # mpv
    # office
    wpsoffice-cn			                              # wps
    # file browser
    nnn                                             # terminal file manager
  ];

  # 允许非自由包
  nixpkgs.config.allowUnfree = true;

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
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

