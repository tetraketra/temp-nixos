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

  systemd.activationScripts.home-manager-restart = lib.mkIf config.system.user.useHomeManager {
    text = ''
      ${pkgs.systemd}/bin/systemctl restart home-manager-${config.system.user.username}.service || true
    '';
    deps = [
      "users"
      "groups"
    ];
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

  home.stateVersion = "25.11";
}