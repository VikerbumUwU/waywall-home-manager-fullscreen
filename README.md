# waywall-home-manager

[Home Manager](https://github.com/nix-community/home-manager) module for configuring [waywall](https://tesselslate.github.io/waywall/) using Nix, with declarative scene management.

## Usage

Add waywall-home-manager to your flake inputs:

```nix
{
  inputs = {
    waywall-home-manager.url = "git+https://codeberg.org/arsoniv/waywall-home-manager.git";
  };
}
```

Add the module to your Home Manager imports:

```nix
{
  home-manager.users.${user}.imports = [
    waywall-home-manager.homeManagerModules.default
  ];
}
```

Enable waywall:

```nix
{
  programs.waywall.enable = true;
}
```

## Config options

`programs.waywall.config` maps 1:1 to the [waywall config table](https://tesselslate.github.io/waywall/01_options.html) (the table returned by `init.lua`).

```nix
{
  programs.waywall.config = {
    input = {
      repeat_rate = 50;
      repeat_delay = 200;
    };

    theme = {
      background = "#22222288";

      ninb_anchor = "bottomleft";
      ninb_opacity = 0.5;
    };
  };
}
```

## Scenes

Scenes are defined under `programs.waywall.scenes` as a list. 
Each scene defines a resolution, sensitivity, mirrors, images, and a keybind for toggling the scene (see waywall docs for correct formatting).

```nix
{
  programs.waywall.scenes = [
    {
      name = "tall-m";
      bind = "shift-1";

      sens = 0.2;

      resolution = {
        w = 320;
        h = 16384;
      };

      mirrors = [
        {
          src = {
            x = 129;
            y = 7902;
            w = 60;
            h = 580;
          };

          dst = {
            x = 0;
            y = 315;
            w = 800;
            h = 450;
          };
        }
      ];

      images = [
        {
          path = "/home/arson/mcsr/overlay.png";

          dst = {
            x = 0;
            y = 315;
            w = 800;
            h = 450;
          };
        }
      ];
    }
  ];
}
```

For each scene, the module generates the required `helpers.res_mirror`/`helpers.res_image` calls and an `actions` entry using the scene's `bind` option to call `helpers.toggle_res`.

> [!NOTE]
> Mirrors and images are resolution-specific rather than scene-specific. Multiple scenes with the same resolution will share mirrors and images. This may be changed in the future.


## Ninjabrain Bot

Optionally install [Ninjabrain Bot](https://github.com/Ninjabrain1/Ninjabrain-Bot) with keybindings to toggle floating and launch the jar:

```nix
{
  programs.waywall.ninjabrainBot = {
    url = "https://github.com/Ninjabrain1/Ninjabrain-Bot/releases/download/...";
    hash = "sha256-...";
    bind = {
      exec = "Ctrl-n";
      toggle = "*-n";
    };
  };
}
```

`ninjabrainBot.url` and `ninjabrainBot.hash` default to Ninjabrain Bot 1.5.2.

## Generated output

The module generates a single file at `$XDG_CONFIG_HOME/waywall/init.lua`.
