with import <nixpkgs> {};

{
  default = callPackage ./build.nix { };

  clang6 = callPackage ./build.nix { inherit (llvmPackages_6) stdenv; };
  libcxx = callPackage ./build.nix { stdenv = llvmPackages_6.libcxxStdenv; };
}
