#!/usr/bin/env bash
# Run claude in docker
# arguments:
#   <dir> Location of code to give to amp

CODE_DIR=$1

if [ -z $CODE_DIR ]; then
    echo "error"
    echo "usage: $0 <code_dir>"
    exit 1
fi

# for debuging add this to run below
#    --entrypoint=/bin/bash \
#    -v ~/.claude/:/home/claude/.claude/ \

# Coming from amp, it's wild to me that claude can't restore a session, especially given how much tracking it has for sessions/projects. It also won't start without this file, but we'll go ahead and strip out the previous projects.
claude_json=$(mktemp)
chmod 600 $claude_json
cat ~/.claude.json | jq '.projects = { 
    "/src": {
      "allowedTools": [],
      "history": [],
      "mcpContextUris": [],
      "mcpServers": {},
      "enabledMcpjsonServers": [],
      "disabledMcpjsonServers": [],
      "hasTrustDialogAccepted": true,
      "projectOnboardingSeenCount": 0,
      "hasClaudeMdExternalIncludesApproved": false,
      "hasClaudeMdExternalIncludesWarningShown": false
    }
  }' > $claude_json

docker_network=""
if [ -z $NETWORK ]; then
    :
else
    docker_network="--network $NETWORK"
fi

docker run \
    -it \
    --rm \
    $docker_network \
    -v ~/.claude/.credentials.json:/home/claude/.claude/.credentials.json \
    -v $CODE_DIR:/src \
    -v $claude_json:/home/claude/.claude.json \
    clauderunner

rm $claude_json
