if [ -f ~/Downloads/gurobi9.0.0_mac64.pkg ]; then
    rm -rf /tmp/gurobi
    mkdir /tmp/gurobi
    pushd /tmp/gurobi
    xar -xf ~/Downloads/gurobi9.0.0_mac64.pkg
    tar xfz */Payload -C /tmp/gurobi
    tar xfz *.tar.gz -C /tmp/gurobi
    pushd */mac64
    mv -f bin/grbprobe bin/grbgetkey ~/Repos/CVX/gurobi/maci64/
    rm -f ~/Repos/CVX/gurobi/maci64/libgurobi*.dylib
    mv -f lib/libgurobi??.dylib ~/Repos/CVX/gurobi/maci64/
    mv -f matlab/gurobi.mexmaci64 ~/Repos/CVX/gurobi/maci64/
    popd
    popd
    rm -rf /tmp/gurobi
fi
if [ -f ~/Downloads/gurobi9.0.0_linux64.tar.gz ]; then
    rm -rf /tmp/gurobi
    mkdir /tmp/gurobi
    pushd /tmp/gurobi
    tar xfz ~/Downloads/gurobi9.0.0_linux64.tar.gz
    pushd */linux64
    mv -f bin/grbprobe bin/grbgetkey ~/Repos/CVX/gurobi/a64/
    rm -f ~/Repos/CVX/gurobi/a64/libgurobi*.so
    cp -fH lib/libgurobi??.so ~/Repos/CVX/gurobi/a64/
    mv -f matlab/gurobi.mexa64 ~/Repos/CVX/gurobi/a64/
    popd
    popd
    rm -rf /tmp/gurobi
fi
if [ $(uname) == Darwin ]; then
    pushd maci64
    install_name_tool -change /Library/gurobi900/mac64/lib/libgurobi90.dylib libgurobi90.dylib gurobi.mexmaci64
    otool -L gurobi.mexmaci64
else
    pushd a64
    chrpath -r '$ORIGIN' gurobi.mexa64
fi
popd
