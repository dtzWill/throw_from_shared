#include "error.h"

extern "C" void foo(int x);

void foo(int x) {
  throw nix::Error(x);
}
