#!/bin/bash
# Use only if you need to perform changes on the user system such as installing software
if ! hash mochad 2>/dev/null; then    
    if jv_yesno "mochad doesn't seem to be installed. Install it?"; then
        jv_install libusb-1.0.0-dev
        wget http://freefr.dl.sourceforge.net/project/mochad/mochad-0.1.15.tar.gz
        tar xzf mochad-0.1.15.tar.gz
        rm mochad-0.1.15.tar.gz
        cd mochad-0.1.15
        ./configure
        make
        sudo make install
        cd../
        rm -rf mochad-0.1.15
    fi
fi
