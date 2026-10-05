{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.my.common.enable = lib.mkEnableOption "Common Apps";

  config = lib.mkIf config.my.common.enable {
    home.packages = with pkgs; [
      firefox
      vscode
      btop
      vlc
      adwaita-icon-theme
      gnome-themes-extra
    ];

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };

    home.sessionVariables = {
      CHROME_FORCE_DARK_MODE = "1";
      ADW_DISABLE_PORTAL = "0";
      COLORFGBG = "15;0";
    };

    dconf.settings = {
      "org/gnome/desktop/background" = {
        picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };
  };
}
