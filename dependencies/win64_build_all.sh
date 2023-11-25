#!/bin/bash

set -e

function cdir() {
        if [ -d "$1" ]; then
               rm -rf "$1"
        fi
        mkdir -p "$1"
}

export CC=x86_64-w64-mingw32-gcc
export CXX=x86_64-w64-mingw32-g++
export CPP=x86_64-w64-mingw32-cpp
export AR=x86_64-w64-mingw32-ar
export RANLIB=x86_64-w64-mingw32-ranlib

if [ "x$DEP_INSTALL_PATH" == "x" ]; then
   echo "DEP_INSTALL_PATH must be set; exiting"
   echo "ex. export DEP_INSTALL_PATH=/tmp/local/dependencies-install_win64"
   exit 1
fi

export PKG_CONFIG_PATH="$DEP_INSTALL_PATH/lib/pkgconfig"
export TARGET_PATH="$DEP_INSTALL_PATH"
cdir "$TARGET_PATH"

pushd glew-1.7.0
CFLAGS="-DGLEW_STATIC=1 -static" GLEW_DEST=$TARGET_PATH make -j$CONCURRENT SYSTEM=linux-x86_64-w64-mingw32 LIBNAME="glew32" install
popd

pushd freetype-2.4.8
CFLAGS="-DFREETYPE_STATIC=1 -static" ./configure --prefix=$TARGET_PATH --host=x86_64-w64-mingw32
make -j$CONCURRENT install
popd

pushd zlib-1.2.5
CFLAGS="-DZLIB_STATIC=1 -static" ./configure --prefix=$TARGET_PATH --64 --static
make -j$CONCURRENT install
popd

pushd glfw-2.7.2/lib/win32
make -f Makefile.win64.cross-mgww64 PREFIX=$TARGET_PATH install
popd

pushd jpeg-8c
CFLAGS="-DJPEG_STATIC=1 -static" ./configure --prefix=$TARGET_PATH --host=x86_64-w64-mingw32 --enable-static=yes --enable-shared=no
make -j$CONCURRENT install
popd

pushd SDL2-2.0.1
./configure --prefix=$TARGET_PATH --host=x86_64-w64-mingw32 --enable-static=yes --enable-shared=no
make -j$CONCURRENT install
popd

pushd curl-7.43.0
./configure --prefix=$TARGET_PATH --host=x86_64-w64-mingw32 --enable-static=yes --enable-shared=no --disable-ldap --enable-shared=no --without-zlib --without-winssl --without-darwinssl --without-ssl --without-gnutls --without-polarssl --without-cyassl --without-nss --without-axtls --without-ca-bundle --without-ca-path --without-libmetalink --without-libssh2 --without-librtmp --without-winidn --without-libidn --without-nghttp2
make -j$CONCURRENT install
popd

#pushd breakpad
#LIBS=-lws2_32 LDFLAGS=-static ./configure --prefix=$TARGET_PATH --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 --disable-tools --enable-static
#make -j$CONCURRENT install
#popd

./win64_build_png.sh
