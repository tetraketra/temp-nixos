{
  config,
  lib,
  inputs,
  ...
}: {
  options.my.kitty.enable = lib.mkEnableOption "Kitty Terminal Emulator";

  config = lib.mkIf config.my.kitty.enable {
    home.file.".config/kitty/kitty.conf".source = ../../dotfiles/kitty.conf;
  };
}
