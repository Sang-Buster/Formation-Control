set -x
if [ -f ~/Downloads/mosektoolsosx64x86.tar.bz2 ]; then
    rm -rf /tmp/mosek
    tar jvfx ~/Downloads/mosektoolsosx64x86.tar.bz2 -C /tmp "*/libmosek64.9.1.dylib" "*/libcilkrts.*.dylib" "*/mosekopt.mexmaci64"
    mv -f /tmp/mosek/9.1/toolbox/r2015aom/mosekopt.mexmaci64 maci64/mosekopt.mexmaci64
    mv -f /tmp/mosek/9.1/tools/platform/osx64x86/bin/* maci64/
    rm -rf /tmp/mosek
fi
if [ -f ~/Downloads/mosektoolslinux64x86.tar.bz2 ]; then
    rm -rf /tmp/mosek
    tar jvfx ~/Downloads/mosektoolslinux64x86.tar.bz2 -C /tmp "*/libmosek64.so.9.1" "*/libcilkrts.so.5" "*/mosekopt.mexa64"
    mv -f /tmp/mosek/9.1/toolbox/r2015aom/mosekopt.mexa64 a64/mosekopt.mexa64
    mv -f /tmp/mosek/9.1/tools/platform/linux64x86/bin/* a64/
    rm -rf /tmp/mosek
fi
if [ -f ~/Downloads/mosektoolswin64x86.zip ]; then
    rm -rf /tmp/mosek
    unzip -d /tmp ~/Downloads/mosektoolswin64x86.zip "*/cilkrts20.dll" "*/mosek64_9_1.dll" "*/mosekopt.mexw64"
    mv -f /tmp/mosek/9.1/toolbox/r2015aom/mosekopt.mexw64 w64/mosekopt.mexw64
    mv -f /tmp/mosek/9.1/tools/platform/win64x86/bin/* w64/
    rm -rf /tmp/mosek
fi
if [ $(uname) != Darwin ]; then
    pushd a64
    for f in *; do 
        patchelf --set-rpath '$ORIGIN' $f
        chrpath -l $f
    done
    popd
fi

