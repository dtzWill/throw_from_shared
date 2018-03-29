#include "error.h"

#include <dlfcn.h>

#include <iostream>
#include <stdexcept>

int main(int argc, char *argv[]) {

  if (argc != 2)
    throw std::invalid_argument("requires exactly 2 arguments");

  auto *h = dlopen(argv[1], RTLD_LOCAL | RTLD_LAZY);
  if (!h) {
    perror("dlopen");
    exit(1);
  }

  typedef void (*fptr)(int);
  fptr fooPtr{(fptr)dlsym(h, "foo")};
  if (!fooPtr) {
    perror("dlsym");
    exit(1);
  }

  try {
    fooPtr(5);
  } catch (nix::Error &e) {
    std::cout << "exception caught!\n";
    e.print(std::cout);
  }

  int c = dlclose(h);
  if (c) {
    perror("dlclose");
    exit(1);
  }

  return 0;
}

