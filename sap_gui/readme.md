# Overview

Automatically installs SAP GUI on Windows

## Prerequisites:

- Win OS 64bit
- S3 bucket with SAP GUI software:

[Download SAP GUI e.g. 7.60 for Windows](https://launchpad.support.sap.com/#/softwarecenter/template/products/%20_APP=00200682500000001943&_EVENT=DISPHIER&HEADER=Y&FUNCTIONBAR=N&EVENT=TREE&NE=NAVIGATE&ENR=73554900100200007184&V=MAINT&TA=ACTUAL&PAGE=SEARCH/SAP%20GUI%20FOR%20WINDOWS%207.60%20CORE)

![image](software.jpg)

## Deployment

### Manually:

```cmd
$ powershell.exe -File "deploy.ps1" "<bucket>" "<directory>"
```

e.g.

```cmd
$ powershell.exe -File "deploy.ps1" "sap-sources" "SAPGUI_CLIENT"
```


### Via AWS Systems Manager (SSM):

1) Choose: 'AWS-RunRemoteScript'
2) Choose Source Type: 'GitHub'
3) Choose Command Line: 'powershell.exe -File "deploy.ps1" "\<bucket\>" "\<directory\>" '

```json
{
"owner":"frumania",
"repository":"aws-sap-scripts",
"path":"sap_gui"
}
```

## Todo

n/a