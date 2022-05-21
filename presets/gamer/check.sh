#!/bin/bash

rm -rf $TARGET/lib/udev/rules.d/
rm -f $TARGET/lib/udev/*.sh

# Replace some /bin programs
pushd "$TARGET/bin/"
    ln -sf busybox login # bypass logind
    [ -x mcedit ] && ln -s mcedit vi 2> /dev/null || true
    [ -f bash ] && ln -sf bash sh || true
    rm -f init*
    [ -f su ] && [ ! -L su ] && chmod u+s su || true
popd
