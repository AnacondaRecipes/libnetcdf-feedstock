#!/bin/bash

declare -a CMAKE_PLATFORM_FLAGS
if [[ ${HOST} =~ .*darwin.* ]]; then
  CMAKE_PLATFORM_FLAGS+=(-DCMAKE_OSX_SYSROOT="${CONDA_BUILD_SYSROOT}")
  export LDFLAGS=${LDFLAGS_CC}
else
  CMAKE_PLATFORM_FLAGS+=(-DCMAKE_TOOLCHAIN_FILE="${RECIPE_DIR}/cross-linux.cmake")
fi

if [[ ${DEBUG_C} == yes ]]; then
  CMAKE_BUILD_TYPE=Debug
else
  CMAKE_BUILD_TYPE=Release
fi

# Build static.
cmake -DCMAKE_INSTALL_PREFIX=${PREFIX} \
      -DCMAKE_INSTALL_LIBDIR:PATH=${PREFIX}/lib \
      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
      -D CMAKE_C="$CC" \
      -D CMAKE_CXX="$CXX" \
<<<<<<< HEAD
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
      -D ENABLE_CDF5=ON \
      $CMAKE_TOOLCHAIN_FLAGS \
      $SRC_DIR
make -j$CPU_COUNT
=======
      -DENABLE_DAP=ON \
      -DENABLE_HDF4=ON \
      -DENABLE_NETCDF_4=ON \
      -DBUILD_SHARED_LIBS=OFF \
      -DENABLE_TESTS=ON \
      -DBUILD_UTILITIES=ON \
      -DENABLE_DOXYGEN=OFF \
      -DENABLE_LOGGING=ON \
      -DCURL_INCLUDE_DIR=${PREFIX}/include \
      -DCURL_LIBRARY=${PREFIX}/lib/libcurl${SHLIB_EXT} \
      ${CMAKE_PLATFORM_FLAGS[@]} \
      ${SRC_DIR}
make -j${CPU_COUNT} ${VERBOSE_CM}
>>>>>>> Fix buffer overrun
# ctest  # Run only for the shared lib build to save time.
make install -j${CPU_COUNT}
make clean

# Build shared.
cmake -DCMAKE_INSTALL_PREFIX=${PREFIX} \
      -DCMAKE_INSTALL_LIBDIR:PATH=${PREFIX}/lib \
      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
      -D CMAKE_C_FLAGS="$CFLAGS" \
<<<<<<< HEAD
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
      -D ENABLE_CDF5=ON \
      -D ENABLE_HDF4_FILE_TESTS=OFF \
      $CMAKE_TOOLCHAIN_FLAGS \
      $SRC_DIR
make -j$CPU_COUNT
make install -j$CPU_COUNT
ctest
=======
      -DENABLE_DAP=ON \
      -DENABLE_HDF4=ON \
      -DENABLE_NETCDF_4=ON \
      -DBUILD_SHARED_LIBS=ON \
      -DENABLE_TESTS=ON \
      -DBUILD_UTILITIES=ON \
      -DENABLE_DOXYGEN=OFF \
      -DENABLE_LOGGING=ON \
      -DCURL_INCLUDE_DIR=${PREFIX}/include \
      -DCURL_LIBRARY=${PREFIX}/lib/libcurl${SHLIB_EXT} \
      ${CMAKE_PLATFORM_FLAGS[@]} \
      ${SRC_DIR}
make -j${CPU_COUNT} ${VERBOSE_CM}
make install -j${CPU_COUNT}
ctest --extra-verbose --debug
>>>>>>> Fix buffer overrun
