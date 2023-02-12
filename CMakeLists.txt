cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    test-lib
    VERSION 0.1.0
    DESCRIPTION "Test library for integration"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    test-lib_test-lib
    source/test-lib.cpp
)
add_library(test-lib::test-lib ALIAS test-lib_test-lib)

include(GenerateExportHeader)
generate_export_header(
    test-lib_test-lib
    BASE_NAME test-lib
    EXPORT_FILE_NAME export/test-lib/test-lib_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(test-lib_test-lib PUBLIC TEST_LIB_STATIC_DEFINE)
endif()

set_target_properties(
    test-lib_test-lib PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME test-lib
    OUTPUT_NAME test-lib
)

target_include_directories(
    test-lib_test-lib ${warning_guard}
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    test-lib_test-lib SYSTEM
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(test-lib_test-lib PUBLIC cxx_std_17)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Examples ----

if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_EXAMPLES "Build examples tree." "${test-lib_DEVELOPER_MODE}")
  if(BUILD_EXAMPLES)
    add_subdirectory(example)
  endif()
endif()

# ---- Developer mode ----

if(NOT test-lib_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of test-lib"
  )
endif()

include(cmake/dev-mode.cmake)
