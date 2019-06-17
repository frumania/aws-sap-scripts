# Overview

Automatically install SAP HANA Cockpit on SLES OS, according to
https://help.sap.com/viewer/df02d156db744412ad1f9e887aba68ad/2.10.0.0/en-US/b4729151dec84b048627bdd004ae5f62.html

## Prerequisites:

- SLES OS
- S3 bucket with downloaded software (via SAP Support Launchpad), as seen below. Please rename accordingly!

[Download SAP HANA Cockpit 2.0 - Linux x86_64](https://launchpad.support.sap.com/#/softwarecenter/template/products/%20_APP=00200682500000001943&_EVENT=DISPHIER&HEADER=Y&FUNCTIONBAR=N&EVENT=TREE&NE=NAVIGATE&ENR=73555000100200005745&V=MAINT&TA=ACTUAL&PAGE=SEARCH/SAP%20HANA%20COCKPIT%202.0)

[Download SAPCAR - Linux x86_64](https://launchpad.support.sap.com/#/softwarecenter/template/products/%20_APP=00200682500000001943&_EVENT=DISPHIER&HEADER=Y&FUNCTIONBAR=N&EVENT=TREE&NE=NAVIGATE&ENR=01200615320100002542&V=MAINT&TA=ACTUAL&PAGE=SEARCH/SAPCAR)

![image](software.jpg)

## Deployment

Can take up to 30min to complete!

### Manually:

```bash
$ chmod 700 deploy.sh
$ ./deploy.sh s3://<bucket>/ <password>
```

e.g.

```bash
$ ./deploy.sh s3://sap-sources/HANA_CLIENT/HANA_COCKPIT/ MyHanaCP123#
```


### Via AWS Systems Manager (SSM):

1) Choose: AWS-RunRemoteScript
2) Source Type: GitHub
3) Source Info:
```json
{
"owner":"frumania",
"repository":"aws-sap-scripts",
"path":"hana_cockpit"
}
```
4) Command Line: deploy.sh s3://\<bucket\>/ \<password\>

## Post-Deployment steps

- (Optional) Create specific user inside target HANA system to be managed from the cockpit
```sql
CREATE USER <username> PASSWORD <password> NO FORCE_FIRST_PASSWORD_CHANGE;
GRANT CATALOG READ to <username>;
GRANT SELECT on SCHEMA _SYS_STATISTICS to <username>;
```
- Check if processes are running correctly

```bash
su h4cadm
```

```bash
xs login
```

```bash
xs apps
```

- Launch HANA Cockpit and add target system(s): 

```bash
https://<hostname>:51031/sap/hana/cockpit/admin/index.html
```

```bash
https://<hostname>:51029/cockpit
```

```bash
User COCKPIT_ADMIN
Password <password>
```

## Todo

n/a