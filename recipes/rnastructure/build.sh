#!/bin/sh

# Fix for OSX build
if [ `uname` == Darwin ]; then
    CPP_FLAGS="${CXXFLAGS} -g -O3 -fopenmp -I${PREFIX}/include"
    DLIBS_SMP="-lpthread -lomp"
else
    CPP_FLAGS="${CXXFLAGS} -fopenmp -g -O3"
    DLIBS_SMP="-lpthread -lgomp"
fi

# build
make CC="${CC}" CXX="${CXX}" CPP_FLAGS="${CPP_FLAGS}" DLIBS_SMP="${DLIBS_SMP}" all

mkdir -p $PREFIX/bin
mv ./exe/* $PREFIX/bin/

# Some of the tools inside the package require the information in /data_tables
# This makes them accessible from a relative path to the binaries.

mkdir -p $PREFIX/share/${PKG_NAME}/data_tables
mv ./data_tables/* $PREFIX/share/${PKG_NAME}/data_tables/
