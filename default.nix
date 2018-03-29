with import <nixpkgs> {};

{
  default = callPackage ./build.nix { useAnchor = false; };
  clang6 = callPackage ./build.nix { useAnchor = false; inherit (llvmPackages_6) stdenv; };
  libcxx = callPackage ./build.nix { useAnchor = false; stdenv = llvmPackages_6.libcxxStdenv; };

  anchored_default = callPackage ./build.nix { useAnchor = true; };
  anchored_clang6 = callPackage ./build.nix { useAnchor = true; inherit (llvmPackages_6) stdenv; };
  anchored_libcxx = callPackage ./build.nix { useAnchor = true; stdenv = llvmPackages_6.libcxxStdenv; };
}
