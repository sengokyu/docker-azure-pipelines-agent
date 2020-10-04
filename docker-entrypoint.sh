#!/bin/bash

set -e

if [ -z "$TOKEN" ]; then
    echo 1>&2 'TOKEN must be specified.'
    echo 1>&2 'Run dockker command with -e TOKEN=...'
    echo 1>&2 'You can get a personal access token from https://dev.azure.com/YOUR_ORG/_usersSettings/tokens'
    exit 1
fi

if [ -z "$URL" -a -z "$ORG" ]; then
    echo 1>&2 'URL or ORG must be specired.'
    echo 1>&2 'Run docker command with -e ORG=... or -e URL=...'
    exit 1
fi

export AGENT_ALLOW_RUNASROOT=yes

cd ${VSTS_AGENT_DIR}

./config.sh \
    --unattended \
    --url "${URL:-https://dev.azure.com/${ORG}}" \
    --auth pat \
    --token "${TOKEN}" \
    --pool "${POOL:-Default}" \
    --agent "${AGENT:-ubuntu-agent}" \
    --replace \
    acceptTeeEula

exec "$@"
