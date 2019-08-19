#!/bin/bash
rm -rf build
meson build --prefix=/usr
cd build
ninja
./com.github.padjis.cronera
cd ..
