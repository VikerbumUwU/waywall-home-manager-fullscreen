{
  lib,
  pkgs,
  ...
}:
let
  ninjabrain-bot-package =
    ninb-cfg:
    pkgs.stdenvNoCC.mkDerivation {
      pname = "ninjabrain-bot-nixwall";
      version = "1.5.2";

      src = pkgs.fetchurl {
        url = ninb-cfg.url;
        hash = ninb-cfg.hash;
      };

      nativeBuildInputs = [ pkgs.makeWrapper ];

      dontUnpack = true;

      installPhase = ''
        install -Dm644 $src $out/share/ninjabrain-bot/ninjabrain-bot.jar

        makeWrapper ${lib.getExe pkgs.temurin-bin-17} $out/bin/ninjabrain-bot \
          --add-flags "-jar $out/share/ninjabrain-bot/ninjabrain-bot.jar" \
          --prefix LD_LIBRARY_PATH : ${
            lib.makeLibraryPath [
              pkgs.libx11
              pkgs.libxinerama
              pkgs.libxkbcommon
              pkgs.libxt
            ]
          }
      '';

      meta = {
        mainProgram = "ninjabrain-bot";
      };
    };
  luaString = s: "\"${lib.escape [ "\"" "\\" ] s}\"";

  luaValue =
    value:
    if value == null then
      "nil"
    else if builtins.isAttrs value then
      "{\n"
      + lib.concatStringsSep "\n" (
        lib.mapAttrsToList (name: val: "  ${name} = ${luaValue val},") (
          lib.filterAttrs (n: v: v != null) value
        )
      )
      + "\n}"
    else if builtins.isList value then
      "{\n" + lib.concatStringsSep "\n" (map (v: "  ${luaValue v},") value) + "\n}"
    else if builtins.isString value then
      luaString value
    else if builtins.isBool value then
      if value then "true" else "false"
    else if builtins.isInt value || builtins.isFloat value then
      toString value
    else
      throw "Unsupported value found when converting to lua";

  generateSceneElements = scene: ''
    ${lib.concatStringsSep "\n" (
      map (mirror: ''
        helpers.res_mirror(
          ${luaValue mirror},
          ${luaValue scene.resolution.w},
          ${luaValue scene.resolution.h}
        )
      '') scene.mirrors
    )}

    ${lib.concatStringsSep "\n" (
      map (image: ''
        helpers.res_image(
          ${luaString image.path},
          ${luaValue image},
          ${luaValue scene.resolution.w},
          ${luaValue scene.resolution.h}
        )
      '') scene.images
    )}
  '';

  generateActions = cfg: ''
    {
    ${lib.concatStringsSep "\n" (
      (map (
        scene:
        "[${luaString scene.bind}] = helpers.toggle_res(${luaValue scene.resolution.w}, ${luaValue scene.resolution.h}, ${luaValue scene.sens}),"
      ) cfg.scenes)
      ++ lib.optional (cfg.ninjabrainBot != null) ''
        [${luaString cfg.ninjabrainBot.bind.toggle}] = helpers.toggle_floating,
        [${luaString cfg.ninjabrainBot.bind.exec}] = function() waywall.exec(${luaString (lib.getExe (ninjabrain-bot-package cfg.ninjabrainBot))}) end,
      ''
    )}
    }
  '';
in
cfg:
let
  sceneElements = lib.concatStringsSep "\n" (map generateSceneElements cfg.scenes);
in
''
  local waywall = require("waywall")
  local helpers = require("waywall.helpers")

  ${sceneElements}

  local config = ${luaValue cfg.config}

  config.actions = ${generateActions cfg}

  config.actions["Shift-O"] = function() waywall.toggle_fullscreen() end,
  
  return config
''
