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
      	"${mod}+Shift+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${mod}+Shift+c" = "kill";
        
        #FOCUS
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus up";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus right";

        #MOVE
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move up";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move left";

        "${mod}+t" = "floating toggle";

        "${mod}+Shift+e" = "reload";
      };
    
      bars = [
	{
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
	}
      ];
    };
  };
}
