{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.my.hyprland.enable = lib.mkEnableOption "Hyprland Compositor";

  config = lib.mkIf config.my.hyprland.enable {
    home.file.".config/hypr/hyprland.conf".source = ../../dotfiles/hyprland.conf;

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
