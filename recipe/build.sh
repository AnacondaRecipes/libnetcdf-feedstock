#!/bin/bash

export CFLAGS="$CFLAGS -I$PREFIX/include"
export LDFLAGS="$LDFLAGS -L$PREFIX/lib"

# Build static.
cmake -D CMAKE_INSTALL_PREFIX=$PREFIX \
      -D CMAKE_C="$CC" \
      -D CMAKE_CXX="$CXX" \
      -D CMAKE_INSTALL_LIBDIR:PATH=$PREFIX/lib \
      -D ENABLE_DAP=ON \
      -D ENABLE_HDF4=ON \
      -D ENABLE_NETCDF_4=ON \
      -D BUILD_SHARED_LIBS=OFF \
      -D ENABLE_TESTS=OFF \
      -D BUILD_UTILITIES=ON \
      -D ENABLE_DOXYGEN=OFF \
      -D ENABLE_LOGGING=ON \
      -D CURL_INCLUDE_DIR=$PREFIX/include \
      -D CURL_LIBRARY=$PREFIX/lib/libcurl${SHLIB_EXT} \
      $SRC_DIR
make -j$CPU_COUNT
# ctest  # Run only for the shared lib build to save time.
make install -j$CPU_COUNT
make clean

# Build shared.
cmake -D CMAKE_INSTALL_PREFIX=$PREFIX \
      -D CMAKE_C_FLAGS="$CFLAGS" \
      -D CMAKE_INSTALL_LIBDIR:PATH=$PREFIX/lib \
      -D ENABLE_DAP=ON \
      -D ENABLE_HDF4=ON \
      -D ENABLE_NETCDF_4=ON \
      -D BUILD_SHARED_LIBS=ON \
      -D ENABLE_TESTS=OFF \
      -D BUILD_UTILITIES=ON \
      -D ENABLE_DOXYGEN=OFF \
      -D ENABLE_LOGGING=ON \
      -D CURL_INCLUDE_DIR=$PREFIX/include \
      -D CURL_LIBRARY=$PREFIX/lib/libcurl${SHLIB_EXT} \
      $SRC_DIR
make -j$CPU_COUNT
make install -j$CPU_COUNT
ctest
