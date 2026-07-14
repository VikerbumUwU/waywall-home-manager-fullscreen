{ lib, ... }:
let
  rect = lib.types.submodule {
    options = {
      x = lib.mkOption {
        type = lib.types.int;
      };

      y = lib.mkOption {
        type = lib.types.int;
      };

      w = lib.mkOption {
        type = lib.types.int;
      };

      h = lib.mkOption {
        type = lib.types.int;
      };
    };
  };

  resolution = lib.types.submodule {
    options = {
      w = lib.mkOption {
        type = lib.types.int;
        default = 0;
      };

      h = lib.mkOption {
        type = lib.types.int;
        default = 0;
      };
    };
  };

  mirror = lib.types.submodule {
    options = {
      src = lib.mkOption {
        type = rect;
      };

      dst = lib.mkOption {
        type = rect;
      };

      depth = lib.mkOption {
        type = lib.types.float;
        default = 0.0;
      };

      shader = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };

      color_key = lib.mkOption {
        type = lib.types.nullOr (
          lib.types.submodule {
            options = {
              input = lib.mkOption {
                type = lib.types.str;
              };
              output = lib.mkOption {
                type = lib.types.str;
              };
            };
          }
        );
        default = null;
      };
    };
  };

  image = lib.types.submodule {
    options = {
      path = lib.mkOption {
        type = lib.types.str;
      };

      dst = lib.mkOption {
        type = rect;
      };

      depth = lib.mkOption {
        type = lib.types.float;
        default = 0.0;
      };
    };
  };

  scene = lib.types.submodule {
    options = {
      resolution = lib.mkOption {
        type = resolution;
        default = { };
      };

      mirrors = lib.mkOption {
        type = lib.types.listOf mirror;
        default = [ ];
      };

      images = lib.mkOption {
        type = lib.types.listOf image;
        default = [ ];
      };

      name = lib.mkOption {
        type = lib.types.str;
      };

      bind = lib.mkOption {
        type = lib.types.str;
      };

      sens = lib.mkOption {
        type = lib.types.nullOr lib.types.float;
        default = null;
      };
    };
  };
in
{
  options.programs.waywall.scenes = lib.mkOption {
    type = lib.types.listOf scene;
    default = [ ];
  };
}
