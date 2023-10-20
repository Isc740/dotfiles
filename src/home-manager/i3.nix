{ config, lib, pkgs, ... }:

let
  mod = "Mod1";
in {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = {
      modifier = mod;
      fonts = [ "Iosevka" ];

      keybindings = lib.mkOptionDefault {
        "${mod}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus up";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus right";

      };
    
      bars = [
        {
          position = "top";
        }
      ];
    };
  };
}