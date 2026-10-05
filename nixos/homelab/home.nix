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
      firefox
      vscode
    ];

    file.".config/hypr/hyprland.conf".source = ./config/hyprland.conf;
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
    mako.enable = true;
    swayidle.enable = true;
    polkit-gnome.enable = true;
  };

  home.stateVersion = "25.11";
}