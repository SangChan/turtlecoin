function(cpprest_find_zlib)
  if(TARGET cpprestsdk_zlib_internal)
    return()
  endif()

  if(APPLE AND NOT IOS)
    # Prefer the homebrew version of zlib
    find_library(ZLIB_LIBRARY NAMES libz.a PATHS /usr/local/Cellar/zlib/1.2.8/lib NO_DEFAULT_PATH)
    find_path(ZLIB_INCLUDE_DIRS NAMES zlib.h PATHS /usr/local/Cellar/zlib/1.2.8/include NO_DEFAULT_PATH)

    if(NOT ZLIB_LIBRARY OR NOT ZLIB_INCLUDE_DIRS)
      find_package(ZLIB REQUIRED)
    endif()
  else()
    SET(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
    find_package(ZLIB REQUIRED)
  endif()

  add_library(cpprestsdk_zlib_internal INTERFACE)
  if(TARGET ZLIB::ZLIB)
    target_link_libraries(cpprestsdk_zlib_internal INTERFACE ZLIB::ZLIB)
  else()
    target_link_libraries(cpprestsdk_zlib_internal INTERFACE "$<BUILD_INTERFACE:${ZLIB_LIBRARY}>")
    target_include_directories(cpprestsdk_zlib_internal INTERFACE "$<BUILD_INTERFACE:${ZLIB_INCLUDE_DIRS}>")
  endif()
endfunction()
