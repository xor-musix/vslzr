#!/bin/bash

set -e

#export CMAKECONFIG=$PWD/cmake
export DEPINST=$TARGET_PATH
export LIBRARY_PATH=$TARGET_PATH/lib/
export CPATH=$TARGET_PATH/include


pushd libpng-1.5.7/
cmake -DCMAKE_INSTALL_PREFIX=$TARGET_PATH -DPNG_SHARED=0 -DPNG_STATIC=1
./configure --prefix=$TARGET_PATH --enable-static --disable-shared
make -j$CONCURRENT install
popd

