{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.my.noctalia.enable =
    lib.mkEnableOption "Noctalia Shell";

  config = lib.mkIf config.my.desktop.noctalia.enable {
    services.noctalia-shell = {
      enable = true;

      settings = {
        bar = {
          density = "comfortable";
          position = "top";
        };

        dock = {
          enabled = true;
        };

        wallpaper = {
          enabled = true;
        };
      };
    };
  };
}