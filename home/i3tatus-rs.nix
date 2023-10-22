{ config, lib, pkgs, ... }:
let
  host = osConfig.networking.hostName;
in
{
  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        blocks = [
          {
            block = "disk_space";
            click = [
              {
                button = "left";
                cmd = "alacritty -e ncdu /";
              }
            ];
          }
          {
            block = "memory";
            format = " $icon $mem_used.eng(prefix:M)($mem_used_percents.eng(w:2)) ";
            format_alt = "$swap_used_percents";
            click = [
              {
                button = "right";
                cmd = "alacritty -e htop";
              }
            ];
          }
          {
            block = "cpu";
            interval = 1;
            format = "$barchart";
            click = [
              {
                button = "left";
                cmd = "alacritty -e htop";
              }
              {
                button = "right";
                cmd = "alacritty -e btop";
              }
            ];
          }
          {
            block = "sound";
            driver = "pulseaudio";
            format = "$output_name {$volume.eng(w:2) |}";
            click = [
              {
                button = "left";
                cmd = "pavucontrol --tab=3";
              }
              {
                button = "right";
                cmd = "alacritty -e pulsemixer";
              }
            ];
            mappings = lib.attrsets.attrByPath [ "${hostName}" ] { } soundBlockMappings;
            headphones_indicator = true;
          }
          {
            block = "time";
            click = [
              {
                button = "left";
                cmd = "brave calendar.google.com";
              }
              {
                button = "right";
                cmd = "brave calendar.google.com";
              }
            ];
          }
        ];
        icons = "awesome4";
        theme = "dracula";
      };
    };
  };

}
