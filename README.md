# Docker container image for Azure Pipelines Agent

# Getting Started with Azure Container Instance

```
az container create -g YourResourceGroup --name YourInstanceName --image sengokyu/azure-pipelines-agent --cpu 2 --memory 2 --environment-variables TOKEN=YourPersonalAccessToken ORG=YourOrganizationName
```

# Supported environment variables

* URL or ORG (required) URL of the server or the organization name of Azure DevOps.
* TOKEN (required) Your Personal Access Token.
* AGENT (optional) Agent name. Default: "ubuntu-agent"
* POOL (optional) Pool name. Default: "Default"

