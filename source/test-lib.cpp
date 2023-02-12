#include <string>

#include "test-lib/test-lib.hpp"

exported_class::exported_class()
    : m_name {"test-lib"}
{
}

auto exported_class::name() const -> const char*
{
  return m_name.c_str();
}
