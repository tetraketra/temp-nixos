{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  options.my.noctalia.enable =
    lib.mkEnableOption "Noctalia Shell";

  config = lib.mkIf config.my.noctalia.enable {
    programs.noctalia = {
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
