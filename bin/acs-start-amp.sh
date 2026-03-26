#!/usr/bin/env bash
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
#
docker_network=""
if [ -z $NETWORK ]; then
    :
else
    docker_network="--network $NETWORK"
fi

extra_docker_args=""
if [ -z $EXTRA_DOCKER_ARGS ]; then
    :
else
    extra_docker_args="$EXTRA_DOCKER_ARGS"
fi

entrypoint=""
if [ -n "$DEBUG" ]; then
    entrypoint="--entrypoint=/bin/$DEBUG"
fi

docker run \
    -it \
    --rm \
    $docker_network \
    $extra_docker_args \
    $entrypoint \
    -e THREAD_ID=$THREAD_ID \
    -v ~/.plumbr/:/home/amp/.plumbr \
    -v ~/.cache/amp/:/home/amp/.cache/amp/ \
    -v ~/.amp/:/home/amp/.amp \
    -v ~/aisnippets:/aisnippets \
    -v ~/.gitconfig/:/home/amp/.gitconfig \
    -v ~/.config/amp/:/home/amp/.config/amp\
    -v ~/aisnippets:/home/amp/.config/amp/commands \
    -v ~/.local/share/amp/:/home/amp/.local/share/amp \
    -v $CODE_DIR:/src \
    amprunner
