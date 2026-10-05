{
  config,
  lib,
  inputs,
  ...
}: {
  options.my.hyprland.enable =
    lib.mkEnableOption "Hyprland Compositor";

  config = lib.mkIf config.my.hyprland.enable {
    programs.hyprland = {
      enable = true;
      home.file.".config/hypr/hyprland.conf".source = ../../dotfiles/hyprland.conf;
    };
  };
}
