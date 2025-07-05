{ pkgs ? import <nixpkgs> {} }:

let
  # https://github.com/fossar/nix-phps
  # https://discourse.nixos.org/t/installing-old-php-version-on-nixos/25693
  nix-phps = builtins.fetchGit { 
    url = "https://github.com/fossar/nix-phps"; 
  };
  phps = import nix-phps;

  php = phps.packages.${builtins.currentSystem}.php84;
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    php
    php.packages.composer
  ];

  shellHook = ''    
    # composer install
  '';
}