# Overview

Automatically installs Amazon Corretto (8.212.04.2) and Eclipse (2018-12) incl. SAP HANA Studio Plugins.

## Prerequisites:

- Win OS 64bit

## Deployment

### Manually:

```cmd
$ powershell.exe -File "deploy.ps1"
```

e.g.

```cmd
$ powershell.exe -File "deploy.ps1"
```


### Via AWS Systems Manager (SSM):

1) Choose 'AWS-RunRemoteScript'
2) Choose Source Type "GitHub"
3) Choose Command Line 'powershell.exe -File "deploy.ps1"

```json
{
"owner":"frumania",
"repository":"aws-sap-scripts",
"path":"hana_studio"
}
```

## Todo

Auto install SAP plugins for Eclipse