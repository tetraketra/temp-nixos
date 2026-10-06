{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.my.hyprland.enable = lib.mkEnableOption "Hyprland Compositor";

  config = lib.mkIf config.my.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      settings = {
        monitor = [
          "HDMI-A-2, preferred, auto, 1, transform, 2"
        ];

        input = {
          kb_layout = "us";
        };

        general = {
          gaps_in = 3;
          gaps_out = 3;

          layout = "dwindle";

          resize_on_border = true;
          border_size = 2;
          extend_border_grab_area = 10;
          "col.active_border" = "rgb(98BB6C)"; 
          "col.inactive_border" = "rgb(54546D)";
        };

        decoration = {
          # TODO: styling
        };

        misc = {
          disable_hyprland_logo = true;
        };

        "exec-once" = [
          "noctalia"
        ];

        "$mod" = "SUPER";

        bind = [
          "$mod, RETURN, exec, kitty"
          "$mod SHIFT, T, exec, kitty"
          "$mod, D, exec, fuzzel"

          "$mod, Q, killactive"

          "$mod, LEFT, movefocus, l"
          "$mod, RIGHT, movefocus, r"
          "$mod, UP, movefocus, u"
          "$mod, DOWN, movefocus, d"

          "$mod SHIFT, LEFT, movewindow, l"
          "$mod SHIFT, RIGHT, movewindow, r"

          "$mod, J, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, I, movefocus, u"
          "$mod, K, movefocus, d"

          "$mod SHIFT, Q, exit"

          "$mod SHIFT, Tab, workspace, m-1"
          "$mod, Tab, workspace, m+1"
        ];
      };
    };
  };
}