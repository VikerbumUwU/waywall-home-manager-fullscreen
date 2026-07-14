{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.waywall;
in
{
  imports = [
    ./options
  ];

  options.programs.waywall.enable = lib.mkEnableOption "waywall";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.waywall
    ];

    xdg.configFile."waywall/init.lua".text = import ./generator.nix { inherit pkgs lib; } cfg;
  };
}
