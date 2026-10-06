{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.self.homeManagerModules.noctalia
    inputs.self.homeManagerModules.kitty
    inputs.self.homeManagerModules.hyprland
    inputs.self.homeManagerModules.common
  ];

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];

    config.allowUnfree = true;
  };

  home = {
    username = "bortemoi";
    homeDirectory = "/home/bortemoi";
  };

  systemd.user.startServices = "sd-switch";
  my.kitty.enable = true;
  my.noctalia.enable = true;
  my.hyprland.enable = true;
  my.common.enable = true;
  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  systemd.user.services.noctalia = {
    Unit = {
      Description = "Noctalia Shell";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.noctalia-shell}/bin/noctalia";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  home.stateVersion = "25.11";
}