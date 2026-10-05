{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    #  inputs.self.nixosModules.example
    # Or modules from other flakes (such as nixos-hardware):
    #  inputs.hardware.nixosModules.common-cpu-amd
    #  inputs.hardware.nixosModules.common-ssd
    # You can also split up your configuration and import pieces of it here:
    #  ./users.nix
    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      #  neovim-nightly-overlay.overlays.default
      # Or define it inline, for example:
      #  (final: prev: {
      #    hi = final.hello.overrideAttrs (oldAttrs: {
      #      patches = [ ./change-hello-to-hi.patch ];
      #   });
      #  })
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
    channel.enable = true; # Disabling is safer but then you lose `nix shell`.
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

  programs.niri.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = "bortemoi";
      };
    };
  };

  hardware.graphics.enable = true;
  services.dbus.enable = true;
  systemd.services.seatd.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

  system.stateVersion = "25.11";
}
