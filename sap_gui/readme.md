# Overview

Automatically installs SAP GUI 7.60 on Windows

## Prerequisites:

- Win OS 64bit
- S3 bucket with software:

![image](software.jpg)

## Deployment

### Manually:

```bash
$ chmod 700 deploy.sh
$ ./deploy.bat "<bucket>" "<folder/prefix>"
```

e.g.

```bash
$ ./deploy.bat "sap-sources" "SAPGUI_CLIENT"
```


### Via AWS Systems Manager (SSM):

1) Choose 'AWS-RunRemoteScript'
2) Choose Source Type "GitHub"
3) Choose Command Line 'deploy.bat "sap-sources" "SAPGUI_CLIENT"'

```json
{
"owner":"frumania",
"repository":"aws-sap-scripts",
"path":"sap_gui"
}
```

## Todo

n/a