{
  description = "Configuration Framework for Waywall";

  outputs = { self }: {
    homeManagerModules.default = import ./modules/home-manager;
  };
}
