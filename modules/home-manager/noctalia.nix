{
  config,
  lib,
  inputs,
  ...
}: {
  options.my.noctalia.enable =
    lib.mkEnableOption "Noctalia Shell";

  config = lib.mkIf config.my.noctalia.enable {
    imports = [
      inputs.noctalia.homeModules.default
    ];

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
