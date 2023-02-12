if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/test-lib-${PROJECT_VERSION}"
      CACHE PATH ""
  )
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package test-lib)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT test-lib_Development
)

install(
    TARGETS test-lib_test-lib
    EXPORT test-libTargets
    RUNTIME #
    COMPONENT test-lib_Runtime
    LIBRARY #
    COMPONENT test-lib_Runtime
    NAMELINK_COMPONENT test-lib_Development
    ARCHIVE #
    COMPONENT test-lib_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    test-lib_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(test-lib_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${test-lib_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT test-lib_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${test-lib_INSTALL_CMAKEDIR}"
    COMPONENT test-lib_Development
)

install(
    EXPORT test-libTargets
    NAMESPACE test-lib::
    DESTINATION "${test-lib_INSTALL_CMAKEDIR}"
    COMPONENT test-lib_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
