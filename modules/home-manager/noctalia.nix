{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  options.my.noctalia.enable = lib.mkEnableOption "Noctalia Shell";

  config = lib.mkIf config.my.noctalia.enable {
    services = {
      mako.enable = true;
      swayidle.enable = true;
      polkit-gnome.enable = true;
    };

    programs = {
      fuzzel.enable = true;
      swaylock.enable = true;
      waybar.enable = true;
      noctalia.enable = true;
    };

    home.file.".config/noctalia/config.toml".source = ../../dotfiles/noctalia.config.toml;
  };
}
