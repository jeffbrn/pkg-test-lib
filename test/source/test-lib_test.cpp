#include <string>

#include "test-lib/test-lib.hpp"

auto main() -> int
{
  auto const exported = exported_class {};

  return std::string("test-lib") == exported.name() ? 0 : 1;
}
