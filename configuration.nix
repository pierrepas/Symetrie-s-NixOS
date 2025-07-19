{ config, pkgs, ... }:
{
  imports =
      ./hardware-configuration.nix
#      (import "${<home-manager>}/nixos")
    ];
#    environment.variables.NIX_PATH = "home-manager=${pkgs.home-manager}/share/nixos/home-manager:$NIX_PATH";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "nixos_pp"; # Define your hostname.
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };
  # Enable the X11 windowing system.
services = {
   desktopManager.plasma6.enable = true;
   displayManager.sddm.enable = true;
   displayManager.sddm.wayland.enable = true;
};
  services.xserver.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
  };
  # Configure console keymap
  environment.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "fr"; # Remplacez "fr" par le code de votre disposition
    # XKB_DEFAULT_VARIANT = "latin9"; # Optionnel : spécifiez une variante si nécessaire
    # XKB_DEFAULT_OPTIONS = "compose:menu"; # Optionnel : spécifiez des options supplémentaires
  };
  console.keyMap = "fr";
  services.power-profiles-daemon.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable sound with pipewire.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  virtualisation.podman = {
  enable = true;
  dockerCompat = true;
};

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.symetrie = {
    isNormalUser = true;
    description = "Symetrie";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      thunderbird
    ];
  };
  programs.firefox.enable = true;
  programs.neovim.enable = true;
  programs.tmux.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.waybar.enable = true;
  xdg.portal.enable = true;
  #xdg.portal.extraPortals = [ pgks.xdg-desktop-portal-gtk ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;
  services.ollama.enable = true;

  # home.packages = with pkgs; [ zsh-powerlevel10k meslo-lgs-nf ];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  # home.file.".p10k.zsh".text = builtins.readFile ./p10k.zsh;
#  programs.home-manager.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    librewolf
    terminator
    htop
    neofetch
    nixpkgs-fmt
    nix-output-monitor
    gcc
    vscode
    dracula-theme
    cascadia-code
    nerd-fonts.zed-mono
    nerd-fonts.ubuntu-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.roboto-mono
    nerd-fonts.jetbrains-mono
    rar
    godot
    godot3
    godotpcktool
    keyd
    direnv
    proton-caller
    wine
    wine64
    distrobox-tui
    boxbuddy
    waybar
    kitty
    swww
    rofi-wayland
    power-profiles-daemon
    vimPlugins.nvchad
    fastfetch
    cowsay
    blueman
    networkmanagerapplet
    libinput
    upscayl
    ripgrep
    dunst
    lmstudio
# KDE
    kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
    kdePackages.kcalc # Calculator
    kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
    kdePackages.kcolorchooser # A small utility to select a color
    kdePackages.kolourpaint # Easy-to-use paint program
    kdePackages.ksystemlog # KDE SystemLog Application
    kdePackages.sddm-kcm # Configuration module for SDDM
    kdiff3 # Compares and merges 2 or 3 files or directories
    kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto UwSB disks
    kdePackages.partitionmanager # Optional Manage the disk devices, partitions and file systems on your computer
    hardinfo2 # System information and benchmarks for Linux systems
    haruna # Open source video player built with Qt/QML and libmpv
    wayland-utils # Wayland utilities
    wl-clipboard # Command-line copy/paste utilities for Wayland

  # Gaming
    lutris
    bottles-unwrapped
    protonup-qt
    #wineWowPackages.waylandFull
  ];

  system.stateVersion = "25.05";

}
