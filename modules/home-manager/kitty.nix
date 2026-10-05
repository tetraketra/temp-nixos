{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.my.kitty.enable = lib.mkEnableOption "Kitty Terminal Emulator";

  config = lib.mkIf config.my.kitty.enable {
    home.packages = [
      pkgs.kitty
    ];
    
    home.file.".config/kitty/kitty.conf".source = ../../dotfiles/kitty.conf;
  };
}
