# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kuala_Lumpur";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ms_MY.UTF-8";
    LC_IDENTIFICATION = "ms_MY.UTF-8";
    LC_MEASUREMENT = "ms_MY.UTF-8";
    LC_MONETARY = "ms_MY.UTF-8";
    LC_NAME = "ms_MY.UTF-8";
    LC_NUMERIC = "ms_MY.UTF-8";
    LC_PAPER = "ms_MY.UTF-8";
    LC_TELEPHONE = "ms_MY.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.blenderboi = {
    isNormalUser = true;
    description = "blenderboi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget






sound.enable = true;

security.rtkit.enable = true;
services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
	jack.enable = true;
};



hardware.opengl = {
enable = true;
driSupport = true;
driSupport32Bit = true;
};

services.xserver.videoDrivers = ["nvidia"];

hardware.nvidia = {

modesetting.enable=true;
powerManagement.enable = false;
powerManagement.finegrained = false;
open = false;
nvidiaSettings = true;

package = config.boot.kernelPackages.nvidiaPackages.stable;

prime = {
sync.enable = true;
intelBusId = "PCI:0:2:0";
nvidiaBusId = "PCI:1:0:0";

};


};






programs.neovim = {
	enable = true;
};


programs.hyprland = {

enable = true;
xwayland.enable = true;

};


services.gvfs.enable=true;
services.udisks2.enable=true;
services.devmon.enable=true;


xdg.portal.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];


  environment.systemPackages = with pkgs; [
	  neofetch
	  kitty
	  lshw
	  firefox
	  wofi
	  wl-clipboard
	  git
	  pamixer
	  pavucontrol
	  pkgs.brightnessctl
	  pkgs.pcmanfm
	  pkgs.mullvad-vpn
	  pkgs.glxinfo
	  pkgs.waybar
	  pkgs.dunst
	  libnotify
	  swww
	  pkgs.networkmanagerapplet
	  peazip
	  popsicle
	  wev
  ];

  fonts.packages = with pkgs; [
  (nerdfonts.override{fonts=["FiraCode"];})


  ];

nix.settings.experimental-features = ["nix-command" "flakes"];

services.mullvad-vpn.enable = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
