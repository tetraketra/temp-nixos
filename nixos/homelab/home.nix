{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # inputs.self.homeManagerModules.example
  ];

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];

    config.allowUnfree = true;
  };

  home = {
    username = "bortemoi";
    homeDirectory = "/home/bortemoi";

    packages = with pkgs; [
      kitty
      fuzzel
      waybar
      firefox
      vscode
    ];
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;

    niri = {
      enable = true;
      settings = {
        spawn-at-startup = [
          {
            command = [
              "${pkgs.noctalia-shell}/bin/noctalia-shell"
            ];
          }
        ];

        input = {
          keyboard.xkb.layout = "us";
          focus-follows-mouse.enable = false;
        };

        layout = {
          gaps = 5;
          center-focused-column = "never";
          default-column-width = {
            proportion = 0.5;
          };
        };

        prefer-no-csd = true;

        binds = {
          "Mod+Return".action.spawn = [ "kitty" ];
          "Mod+D".action.spawn = [ "fuzzel" ];

          "Mod+Q".action.close-window = {};
 
          "Mod+Left".action.focus-column-left = {};
          "Mod+Right".action.focus-column-right = {};
          "Mod+Up".action.focus-window-up = {};
          "Mod+Down".action.focus-window-down = {};

          "Mod+Shift+Left".action.move-column-left = {};
          "Mod+Shift+Right".action.move-column-right = {};

          "Mod+J".action.focus-column-left = {};
          "Mod+L".action.focus-column-right = {};
          "Mod+I".action.focus-window-up = {};
          "Mod+K".action.focus-window-down = {};

          "Mod+Shift+Q".action.quit = {};
        };

        outputs."HDMI-A-2" = {
          trasnform = "180";
        };
      };
    };
  };

  services.noctalia-shell = {
    enable = true;
  };

  home.stateVersion = "25.11";
}