{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.self.nixosModules.fonts
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
    };
    channel.enable = true;
  };
  
  networking.hostName = "homelab";
  networking.hostId = "6b6c9563";

  users.users = {
    root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqJD0ytcvuTkmHuPcLQK6XfBThIL58XcilCjDUif0iC borte@bortemoi.com" # Workstation
    ];

    bortemoi = {
      isNormalUser = true;
      description = "bortemoi";
      initialPassword = "bortemoi";
      extraGroups = [ "networkmanager" "wheel" "seat" "video" "input" "render" ];
    };
  };
  
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
    };
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.greetd = { 
    enable = true; 
    settings = { 
      default_session = { 
        command = "${pkgs.hyprland}/bin/Hyprland"; 
        user = "bortemoi"; 
      }; 
    }; 
  };

  hardware.graphics.enable = true;
  systemd.services.seatd.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

  system.stateVersion = "25.11";
}
