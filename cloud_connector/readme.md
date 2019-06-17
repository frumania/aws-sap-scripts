# Overview

Automatically deploy SAP Cloud Connector
https://help.sap.com/viewer/cca91383641e40ffbe03bdc78f00f681/Cloud/en-US/f069840fa34c4196a5858be33a2734ea.html

## Prerequisites:

- SLES OS 64bit

## Deployment

### Manually:

```bash
$ chmod 700 deploy.sh
$ ./deploy.sh
```

### Via AWS Systems Manager (SSM):

1) Choose: AWS-RunRemoteScript
2) Source Type: GitHub
3) Source Info:
```json
{
"owner":"frumania",
"repository":"aws-sap-scripts",
"path":"cloud_connector"
}
```
4) Command Line: deploy.sh

## Post-Deployment steps

Service Lifecycle
> service scc_daemon stop|restart|start|status

Launch Admin UI

```js
https://<hostname>:8443
```