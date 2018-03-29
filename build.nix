{ stdenv, useAnchor }:

stdenv.mkDerivation {
  name = "test${if useAnchor then "-anchored" else ""}";

  src = fetchGit ./.;

  NIX_CFLAGS_COMPILE = [ "-Wall" "-Wextra" "-fPIC" "-DUSE_ANCHOR=${if useAnchor then "1" else "0"}" ];

  buildPhase = if useAnchor then ''
    $CXX ./anchor.cpp -o libanchor.so -shared -Wl,-soname,libanchor.so
    $CXX ./test.cpp -o libtest.so -shared -Wl,-soname,libtest.so -L. -lanchor -Wl,-rpath,$out/lib
    $CXX ./main.cpp -o main -ldl -L. -lanchor -Wl,-rpath,$out/lib
  '' else ''
    $CXX ./test.cpp -o libtest.so -shared -Wl,-soname,libtest.so
    $CXX ./main.cpp -o main -ldl
  '';

  installPhase = ''
    mkdir -p $out/{bin,lib}
    mv *.so $out/lib
    mv main $out/bin
  '';

  doInstallCheck = true;

  installCheckPhase = ''
    $out/bin/main $out/lib/libtest.so
  '';
}
