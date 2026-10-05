{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: 
let
  kanagawa-vscode = pkgs.vscode-utils.buildVscodeExtension {
    pname = "kanagawa";
    version = "0.0.1";

    # nix-prefetch-url --unpack \
    #   https://github.com/barklan/kanagawa.vscode/archive/refs/heads/main.tar.gz
    src = pkgs.fetchFromGitHub {
      owner = "barklan";
      repo = "kanagawa.vscode";
      rev = "main";
      hash = "sha256-0pmixmzhmn4r5xbi999mcwfpj4pl96aaqsdzlkyklzdr9nb2n6vx=";
    };

    vscodeExtPublisher = "barklan";
    vscodeExtName = "kanagawa";
  };
in
{
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

    # Theming shotgun.
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

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        kanagawa-vscode
      ];

      userSettings = {
        "workbench.colorTheme" = "Kanagawa";
        "editor.semanticHighlighting.enabled" = true;
        "rust-analyzer.highlighting.strings" = true;
      };
    };
  };
}
