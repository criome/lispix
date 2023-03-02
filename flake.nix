{

  description = "Lispix - Lisp on Nix";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    flake-utils.url = github:numtide/flake-utils;
    elispix = { url = path:./nix/elispix; flake = false; };
  };

  outputs = { self, nixpkgs, flake-utils, elispix }:
    let
      mkOutputsFromSystem = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          inherit (pkgs) callPackage;
          packages = callPackage ./. { };
          lispixEl = callPackage (import inputs.elispix);
        in
        { inherit packages; };

      nixOSApi = flake-utils.lib.eachDefaultSystem mkOutputsFromSystem;

      kriomOSApi = {
        SobUyrldz = {
          lispixEl = {
            modz = [ "pkgs" ];
            src = inputs.elispix;
            lamdy = import (inputs.elispix);
          };

          packages = {
            modz = [ "pkgs" ];
            src = null;
            lamdy = import ./.;
          };
        };
      };

    in
    nixOSApi // kriomOSApi;

}
