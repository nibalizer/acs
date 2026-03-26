#!/bin/bash
echo "Setting up vim connection"
/opt/nvim-amp-setup.sh

echo "amp --version"
amp --version

if [ ! -z $THREAD_ID ]; then
    amp threads continue $THREAD_ID 
else
    amp
fi
