{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.my.hyprland.enable = lib.mkEnableOption "Hyprland Compositor";

  config = lib.mkIf config.my.hyprland.enable {
    home.packages = [
      pkgs.hyprland
    ];

    home.file.".config/hypr/hyprland.conf".source = ../../dotfiles/hyprland.conf;
  };
}
