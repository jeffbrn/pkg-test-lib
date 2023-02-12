cmake_minimum_required(VERSION 3.14)

project(test-libTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)
include(../cmake/windows-set-path.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(test-lib REQUIRED)
  enable_testing()
endif()

# ---- Tests ----

add_executable(test-lib_test source/test-lib_test.cpp)
target_link_libraries(test-lib_test PRIVATE test-lib::test-lib)
target_compile_features(test-lib_test PRIVATE cxx_std_17)

add_test(NAME test-lib_test COMMAND test-lib_test)
windows_set_path(test-lib_test test-lib::test-lib)

# ---- End-of-file commands ----

add_folders(Test)
