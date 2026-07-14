{ lib, ... }: {
  options.programs.waywall.config = lib.mkOption {
    type = lib.types.submodule {
      options = {
        input = lib.mkOption {
          type = lib.types.nullOr (
            lib.types.submodule {
              options = {
                layout = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  default = null;
                };

                model = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  default = null;
                };

                rules = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  default = null;
                };

                variant = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  default = null;
                };

                options = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  default = null;
                };

                remaps = lib.mkOption {
                  type = lib.types.nullOr lib.types.attrs;
                  default = null;
                };

                repeat_rate = lib.mkOption {
                  type = lib.types.nullOr lib.types.int;
                  default = null;
                };

                repeat_delay = lib.mkOption {
                  type = lib.types.nullOr lib.types.int;
                  default = null;
                };

                sensitivity = lib.mkOption {
                  type = lib.types.nullOr lib.types.float;
                  default = null;
                };

                confine_pointer = lib.mkOption {
                  type = lib.types.nullOr lib.types.bool;
                  default = null;
                };
              };
            }
          );
          default = null;
        };

        theme = lib.mkOption {
          type = lib.types.nullOr (
            lib.types.submodule {
              options = {
                background = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  default = null;
                };

                background_png = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  default = null;
                };

                cursor_theme = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  default = null;
                };

                cursor_icon = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  default = null;
                };

                cursor_size = lib.mkOption {
                  type = lib.types.nullOr lib.types.int;
                  default = null;
                };

                ninb_anchor = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  default = null;
                };

                ninb_opacity = lib.mkOption {
                  type = lib.types.nullOr lib.types.float;
                  default = null;
                };
              };
            }
          );
          default = null;
        };
      };
    };

    default = { };
  };
}
