{ stdenv }:

stdenv.mkDerivation {
  name = "test";

  src = fetchGit ./.;

  buildPhase = ''
    $CXX ./test.cpp -o libtest.so -shared -Wl,-soname,libtest.so -fPIC -Wall -Wextra
    $CXX ./main.cpp -o main -fPIC -ldl -Wall -Wextra
  '';

  installPhase = ''
    mkdir -p $out/{bin,lib}
    mv libtest.so $out/lib
    mv main $out/bin
  '';

  doInstallCheck = true;

  installCheckPhase = ''
    $out/bin/main $out/lib/libtest.so
  '';
}
