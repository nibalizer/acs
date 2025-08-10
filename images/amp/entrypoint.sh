#!/bin/bash

echo "amp --version"
amp --version

if [ ! -z $THREAD_ID ]; then
    amp threads continue $THREAD_ID 
else
    amp
fi
