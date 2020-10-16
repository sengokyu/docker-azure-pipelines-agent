#!/bin/bash

set -e

VSTS_AGENT_DIR=/opt/vstsagent

get_latest_vsts_agent_url() {
    local assets_url=$(curl -sL https://api.github.com/repos/Microsoft/vsts-agent/releases/latest | jq -r '.assets[0].browser_download_url')
    
    curl -L $assets_url | jq -r '. | map(select(.platform == "linux-x64")) | .[0].downloadUrl'
}

download_vsts_agent() {
    local targzurl=$(get_latest_vsts_agent_url)

    mkdir $VSTS_AGENT_DIR && curl -L $(get_latest_vsts_agent_url) | tar zxf - -C $VSTS_AGENT_DIR
}

main() {
    download_vsts_agent
}

## Main
main
