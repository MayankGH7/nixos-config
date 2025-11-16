{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];
  
  nix.settings = {
	  extra-substituters = [ "https://vicinae.cachix.org" ];
	  extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];

  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos";
  networking.useNetworkd = true;
  services.resolved.enable = true;
  networking.wireless.iwd.enable = true;
  networking.resolvconf.enable = false;
  networking.wireless.enable = false;
  networking.networkmanager.enable = false;

  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.mynk = {
    isNormalUser = true;
    description = "Mayank Yadav";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
    ];
  };
  users.defaultUserShell = pkgs.zsh;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
	vim
	neovim
	wget
	alacritty
	niri
	brightnessctl
	sof-firmware
	mpv
	pipewire
	tmux
	seatd
	acpi
	fzf
	zsh
	cryptsetup
	fuzzel
	chromium
	bibata-cursors
	zoxide
	fd
	hyprpicker
	swaybg
	iwd
	git
	httpie
	wl-clipboard
	home-manager
	ripgrep
	dust
	bluetui
	nautilus
	fastfetch
	btop
	gcc
	clang
	zig
	waybar
	stow
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.niri.enable = true;
  programs.zoxide.enable = true;
  programs.neovim.defaultEditor = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      # theme = "refined";
      plugins = [ "git" "z" "sudo"];
    };
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch";
      enix = "sudo vim /etc/nixos/configuration.nix";
    };
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };


  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
	noto-fonts
	noto-fonts-cjk-sans
	noto-fonts-cjk-serif
	noto-fonts-color-emoji
	noto-fonts-lgc-plus
    ];
  };


  # List services that you want to enable:
  services.openssh.enable = true;
  services.power-profiles-daemon.enable = true;
  services.displayManager.ly = {
    enable = true;
    settings = {
      vi_mode = true;
      default_vi_mode = "normal";	
      bigclock = true;
      allow_empty_password = false;
      box_title = "Welcome, Master Mayank";
    };
  };


  system.stateVersion = "25.05";

  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "19";
    NIX_SHELL_PREFER_ZSH="1";
  };
}
