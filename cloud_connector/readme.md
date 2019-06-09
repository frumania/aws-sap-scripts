# Overview

Automatically deploy SAP Cloud Connector
https://help.sap.com/viewer/cca91383641e40ffbe03bdc78f00f681/Cloud/en-US/f069840fa34c4196a5858be33a2734ea.html

## Prerequisites:

- SLES/RH OS

## Deployment

### Manually:

```bash
$ chmod 700 deploy.sh
$ ./deploy.sh
```

### Via AWS Systems Manager (SSM):

1) Choose 'AWS-RunRemoteScript'
2) Choose Source Type "GitHub"
3) Choose Command Line "deploy.sh"

```json
{
"owner":"frumania",
"repository":"aws-sap-scripts",
"path":"cloud_connector"
}
```

## Post-Deployment steps

Service Lifecycle
> service scc_daemon stop|restart|start|status