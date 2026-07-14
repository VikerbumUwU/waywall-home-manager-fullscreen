{ lib, ... }: {
  options.programs.waywall.ninjabrainBot = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.submodule {
        options = {
          url = lib.mkOption {
            type = lib.types.str;
            default = "https://github.com/Ninjabrain1/Ninjabrain-Bot/releases/download/1.5.2/Ninjabrain-Bot-1.5.2.jar";
          };

          hash = lib.mkOption {
            type = lib.types.str;
            default = "sha256-mAmfYyGpDUrOwTQA6G0F96+NYOVjnC84Qn6WjccUUP8=";
          };

          bind = lib.mkOption {
            type = lib.types.submodule {
              options = {
                exec = lib.mkOption {
                  type = lib.types.str;
                };

                toggle = lib.mkOption {
                  type = lib.types.str;
                };
              };
            };
          };
        };
      }
    );

    default = null;
  };
}
