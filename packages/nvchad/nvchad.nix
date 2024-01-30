{ lib, stdenv, pkgs }:

let
  custom = ./custom;
in  
stdenv.mkDerivation {
    pname = "nvchad";
    version = "2.0.0";

    src = pkgs.fetchFromGithub {
      owner = "NvChad";
      repo = "NvChad";
      rev = "refs/heads/v2.0";
      sha256 = "sha256-6O8NmVlauPuvPVv60bcwqFeS/UZJWZC1/Xr23a9GWDM=";
      };

    installPhase = ''
      mkdir $out
      cp -r * "$out/"
      mkdir -p "$out/lua/custom"
      cp -r ${custom}/* "$out/lua/custom/"
    '';

    meta = with lib; {
        description = "NvChad";
        homepage = "https://github.com/NvChad/NvChad";
        platforms = platforms.all;
        maintainers = [ maintainers.scorp ];
        license = licenses.gpl3;
      };
  }
