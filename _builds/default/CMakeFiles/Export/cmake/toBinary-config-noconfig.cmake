#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "toBinary" for configuration ""
set_property(TARGET toBinary APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(toBinary PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "CXX"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libtoBinary.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS toBinary )
list(APPEND _IMPORT_CHECK_FILES_FOR_toBinary "${_IMPORT_PREFIX}/lib/libtoBinary.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)