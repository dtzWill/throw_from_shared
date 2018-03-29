#ifndef NIX_ERROR_H
#define NIX_ERROR_H

#include <stdexcept>

namespace nix {

class Error : public std::exception {
  int id = 0;

  const char * what() const noexcept { return "an 'Error' occurred, beep boop"; }
};


} // end namespace nix

#endif // NIX_ERROR_H
