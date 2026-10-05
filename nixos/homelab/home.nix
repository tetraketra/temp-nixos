{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.self.homeManagerModules.noctalia
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

    file.".config/niri/config.kdl".text = ''
      output "HDMI-A-2" {
        transform "180"
      }

      input {
        keyboard {
          xkb {
            layout "us"
          }
        }
      }

      layout {
        gaps 5
        center-focused-column "never"

        default-column-width {
          proportion 0.5
        }
      }

      prefer-no-csd

      spawn-at-startup "noctalia"

      binds {
        Mod+Return { spawn "kitty"; }
        Mod+D { spawn "fuzzel"; }

        Mod+Q { close-window; }

        Mod+Left { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Up { focus-window-up; }
        Mod+Down { focus-window-down; }

        Mod+Shift+Left { move-column-left; }
        Mod+Shift+Right { move-column-right; }

        Mod+J { focus-column-left; }
        Mod+L { focus-column-right; }
        Mod+I { focus-window-up; }
        Mod+K { focus-window-down; }

        Mod+Shift+Q { quit; }
      }
    '';
  };

  my.noctalia.enable = true;
  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home.stateVersion = "25.11";
}