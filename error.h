#ifndef NIX_ERROR_H
#define NIX_ERROR_H

#include <stdexcept>
#include <cstdlib>

namespace nix {

class Error : public std::exception {
  int id;

public:
  Error(int id) : id(id) {};

  template <typename T>
  void print(T & O) const {
    O << "an 'Error' occurred, beep boop, id=" << id << "\n";
  }

#if USE_ANCHOR
  virtual void anchor();
#endif
};


} // end namespace nix

#endif // NIX_ERROR_H
