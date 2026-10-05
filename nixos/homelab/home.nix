{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.self.homeManagerModules.noctalia
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

    packages = with pkgs; [
      swaybg
      firefox
      vscode
    ];

    file.".config/niri/config.kdl".source = ./config.niri.config.kdl;
  };

  my.noctalia.enable = true;
  programs = {
    home-manager.enable = true;
    git.enable = true;
    kitty.enable = true;
    fuzzel.enable = true;
    swaylock.enable = true;
    waybar.enable = true;
  };

  services = {
    mako.enable = true; # notification daemon
    swayidle.enable = true; # idle management daemon
    polkit-gnome.enable = true; # polkit
  };

  home.stateVersion = "25.11";
}