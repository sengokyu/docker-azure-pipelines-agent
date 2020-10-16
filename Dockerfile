FROM ubuntu:18.04

ENV VSTS_AGENT_VERSION=2.175.2
ENV DOTNET_RUNTIME_VERSION=3.1
ENV VSTS_AGENT_DIR=/opt/vstsagent

## Configure tzdata package in advance
COPY etc/timezone /etc
RUN ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt-get update && apt-get install -y \
    tzdata \
    ca-certificates \
    build-essential \
    curl \
    jq \
    zip \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY etc/apt /etc/apt

RUN apt-get update && apt-get install -y \
    azure-cli \
    dotnet-runtime-${DOTNET_RUNTIME_VERSION} \
    && rm -rf /var/lib/apt/lists/*

COPY bin /usr/local/bin

RUN download-vsts-agent.sh

ENTRYPOINT [ "docker-entrypoint.sh" ]

## So, CMD does not support variables substitution.
## Use a immidiate file path.
##
## --once option indicate stop process by a job.
CMD [ "/opt/vstsagent/run.sh" ]
