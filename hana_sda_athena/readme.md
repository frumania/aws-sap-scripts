# Overview

Automatically configure SLES OS to allow AWS Athena as remote data source for SAP HANA. Based on
https://aws.amazon.com/de/blogs/awsforsap/run-federated-queries-to-an-aws-data-lake-with-sap-hana/

## Prerequisites:

- SLES OS
- SAP HANA
- Assigned EC2 instance role with policy "AmazonAthenaFullAccess" or similar.
- S3 bucket to store logs

## Deployment

### Manually:

```bash
$ chmod 700 deploy.sh
$ ./deploy.sh s3://aws-athena-hana-int/logs/ eu-central-1
```

### Via AWS Systems Manager (SSM):

1) Choose 'AWS-RunRemoteScript'
2) Choose Source Type "GitHub"
3) Choose Command Line "deploy.sh s3://aws-athena-hana-int/logs/ eu-central-1"

```json
{
"owner":"frumania",
"repository":"aws-sap-scripts",
"path":"hana_sda_athena"
}
```

## Post-Deployment steps

- Restart SAP HANA e.g. HDB stop -> HDB start
- In HANA Stuio: Add Athena as Remote source

## Todo

- Automated Test