{
  description = "SPlayer-Next NixOS development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs { inherit system; };
    in pkgs.mkShell {
      packages = with pkgs; [
        stdenv
        nodejs
        electron_43
        cargo
        rustc
        python3
        pkg-config
        alsa-lib
        libclang
        openssl
        appimage-run
        fish
      ];

      shellHook = ''
        export LIBCLANG_PATH=${pkgs.libclang.lib}/lib
        export BINDGEN_EXTRA_CLANG_ARGS="-I${pkgs.stdenv.cc.libc.dev}/include"
        exec fish
      '';
    };
  };
}
