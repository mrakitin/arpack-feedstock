#!/bin/sh

mkdir build && cd build

for shared_libs in OFF ON
do
  cmake \
    -DCMAKE_PREFIX_PATH=${PREFIX} \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DBUILD_SHARED_LIBS=${shared_libs} \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
    ..

  make -j${CPU_COUNT}
done
cp lib/libarpack${SHLIB_EXT} libarpack.a ${PREFIX}/lib
DYLD_FALLBACK_LIBRARY_PATH=${PREFIX}/lib make check -j${CPU_COUNT}
