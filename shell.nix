{ pkgs ? import <nixpkgs> {} }:

let
  # https://github.com/fossar/nix-phps
  # https://discourse.nixos.org/t/installing-old-php-version-on-nixos/25693
  nix-phps = builtins.fetchGit { 
    url = "https://github.com/fossar/nix-phps"; 
  };
  phps = import nix-phps;

  php = phps.packages.${builtins.currentSystem}.php84;
  node = pkgs.nodejs_22; # lts
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    node
    php
    php.packages.composer
    wp-cli
    docker
  ];

  buildInputs = with pkgs;[

  ];

  shellHook = ''
    export PATH="$PWD/node_modules/.bin/:$PATH"
    
    npm install
    composer install
  '';
}