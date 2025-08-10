#!/bin/bash
# Run amp in docker
# arguments:
#   <dir> Location of code to give to amp
#   <thread> [opitonal] amp thread to continue

CODE_DIR=$1
THREAD_ID=$2

if [ -z $CODE_DIR ]; then
    echo "error"
    echo "usage: $0 <code_dir> <thread-id>"
    exit 1
fi

# for debuging add this to run below
#    --entrypoint=/bin/bash \

docker run \
    -it \
    --rm \
    -e THREAD_ID=$THREAD_ID \
    -v ~/.cache/amp/:/home/amp/.cache/amp/ \
    -v ~/.amp/:/home/amp/.amp \
    -v ~/.local/share/amp/:/home/amp/.local/share/amp \
    -v $CODE_DIR:/src \
    amprunner
