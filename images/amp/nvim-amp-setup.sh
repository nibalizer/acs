#!/bin/bash
set -x

echo 'start "nvim"'

/opt/nvim &
disown
sleep 1

echo "nvim pid"
cat /tmp/nvim.pid
pid=$(cat /tmp/nvim.pid)

echo "editing json file"
cat ~/.local/share/amp/ide/42069.json  | jq --argjson pid $pid '.pid=$pid' > ~/.local/share/amp/ide/1111.json


PORT=42069
socat TCP-LISTEN:${PORT},fork TCP:172.17.0.1:${PORT} &
disown
echo "socat setup lets cook"
