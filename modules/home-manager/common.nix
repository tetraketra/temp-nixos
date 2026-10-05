{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.my.common.enable = lib.mkEnableOption "Common Apps";

  config = lib.mkIf config.my.common.enable {
    home.packages = [
      pkgs.firefox
      pkgs.vscode
      pkgs.btop
      pkgs.vlc
    ];
  };
}
