#!/bin/bash

set -e

export CMAKECONFIG=$PWD/cmake
export DEPINST=$TARGET_PATH
export LIBRARY_PATH=$TARGET_PATH/lib/
export CPATH=$TARGET_PATH/include


#mkdir libpng-1.5.7/build
#pushd libpng-1.5.7/build
pushd libpng-1.5.7/
cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/Toolchain-mingw64.cmake -DCMAKE_INSTALL_PREFIX=$TARGET_PATH -DPNG_SHARED=0 -DPNG_STATIC=1
#../../dependencies/libpng-1.5.7/configure --prefix=$TARGET_PATH --host=x86_64-w64-mingw32 --enable-static --disable-shared
make -j$CONCURRENT install
popd

