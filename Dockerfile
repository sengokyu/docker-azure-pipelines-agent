FROM ubuntu:18.04

ENV VSTS_AGENT_VERSION=2.174.3
ENV DOTNET_SDK_VERSION=2.2
ENV VSTS_AGENT_DIR=/opt/vstsagent

## Configure tzdata package in advance
COPY etc/timezone /etc
RUN ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime

RUN apt-get update && apt-get install -y \
    tzdata \
    ca-certificates \
    build-essential \
    curl \
    jq \
    zip \
    git \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

COPY etc/apt /etc/apt

RUN apt-get update && apt-get install -y \
    azure-cli \
    dotnet-sdk-${DOTNET_SDK_VERSION} \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /opt/vstsagent \
    && curl -sL https://vstsagentpackage.azureedge.net/agent/${VSTS_AGENT_VERSION}/vsts-agent-linux-x64-${VSTS_AGENT_VERSION}.tar.gz | tar zxf - -C ${VSTS_AGENT_DIR}

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "${VSTS_AGENT_DIR}/run.sh", "--once" ]
