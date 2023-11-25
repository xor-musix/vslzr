#!/bin/bash

set -e

function cdir() {
        if [ -d "$1" ]; then
               rm -rf "$1"
        fi
        mkdir -p "$1"
}

export CC=gcc
export CXX=g++
export CPP=cpp
export AR=ar
export RANLIB=ranlib

if [ "x$DEP_INSTALL_PATH" == "x" ]; then
   echo "DEP_INSTALL_PATH must be set; exiting"
   echo "ex. export DEP_INSTALL_PATH=/tmp/local/dependencies-install_linux"
   exit 1
fi

export PKG_CONFIG_PATH="$DEP_INSTALL_PATH/lib/pkgconfig"
export TARGET_PATH="$DEP_INSTALL_PATH"
cdir "$TARGET_PATH"

# needs: libxmu-dev
pushd glew-1.7.0
CFLAGS="-DGLEW_STATIC=1 -static" GLEW_DEST=$TARGET_PATH make -j$CONCURRENT install
popd

pushd freetype-2.4.8
./configure --prefix=$TARGET_PATH
make -j$CONCURRENT install
popd

pushd zlib-1.2.5
CFLAGS="-DZLIB_STATIC=1 -static" ./configure --prefix=$TARGET_PATH --64 --static
make -j$CONCURRENT install
popd

pushd glfw-2.7.2/
make PREFIX=$TARGET_PATH x11-install
popd

pushd jpeg-8c
CFLAGS="-DJPEG_STATIC=1 -static" ./configure --prefix=$TARGET_PATH --host=x86_64-linux-gnu --enable-static=yes --enable-shared=no
make -j$CONCURRENT install
popd

pushd SDL2-2.0.1
./configure --prefix=$TARGET_PATH --enable-static=yes --enable-shared=no --disable-input-tslib
make -j$CONCURRENT install
popd

pushd curl-7.43.0
./configure --prefix=$TARGET_PATH --enable-static=yes --disable-ldap --enable-shared=no  --disable-shared  --without-zlib --without-winssl --without-darwinssl --without-ssl --without-gnutls --without-polarssl --without-cyassl --without-nss --without-axtls --without-ca-bundle --without-ca-path --without-libmetalink --without-libssh2 --without-librtmp --without-winidn --without-libidn --without-nghttp2 --disable-rtsp --disable-ipv6 --disable-manual
make -j$CONCURRENT install
popd

#pushd breakpad
#LIBS=-lws2_32 LDFLAGS=-static ./configure --prefix=$TARGET_PATH --disable-tools --enable-static
#make -j$CONCURRENT install
#popd

./linux_build_png.sh
