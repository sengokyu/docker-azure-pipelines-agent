# Docker container image for Azure Pipelines Agent

# Getting Started 

## With Docker

```
docker run -d -e TOKEN=YourPersonalAccessToken -e ORG=YourOrganizationName sengokyu/azure-pipelines-agent
```

## With Azure Container Instance

```
az container create -g YourResourceGroup --name YourInstanceName --image sengokyu/azure-pipelines-agent --cpu 2 --memory 2 --environment-variables TOKEN=YourPersonalAccessToken ORG=YourOrganizationName
```

# Supported environment variables

* URL or ORG (required) URL of the server or the organization name of Azure DevOps.
* TOKEN (required) Your Personal Access Token.
* AGENT (optional) Agent name. Default: "agent-$(hostname)"
* POOL (optional) Pool name. Default: "Default"


# About the container itself

## Base image

mcr.microsoft.com/dotnet/core/runtime:3.1-bionic

## Installed packages

* tzdata
* ca-certificates
* build-essential
* curl
* jq
* zip
* git
* azure-cli
