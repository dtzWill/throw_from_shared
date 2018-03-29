{ stdenv }:

stdenv.mkDerivation {
  name = "test";

  src = fetchGit ./.;

  buildPhase = ''
    $CXX ./anchor.cpp -o libanchor.so -shared -Wl,-soname,libanchor.so -fPIC -Wall -Wextra
    $CXX ./test.cpp -o libtest.so -shared -Wl,-soname,libtest.so -fPIC -Wall -Wextra -L. -lanchor -Wl,-rpath,$out/lib
    $CXX ./main.cpp -o main -fPIC -ldl -Wall -Wextra -L. -lanchor -Wl,-rpath,$out/lib
  '';

  installPhase = ''
    mkdir -p $out/{bin,lib}
    mv libanchor.so libtest.so $out/lib
    mv main $out/bin
  '';

  doInstallCheck = true;

  installCheckPhase = ''
    $out/bin/main $out/lib/libtest.so
  '';
}
