#!/bin/sh
if [[ ! -f /config/config.yaml ]]; then
    cp /defaults/config.yaml /config
fi

octoprint serve -b /config
