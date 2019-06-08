
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
$ deploy.sh -bucket s3://aws-athena-hana-int/logs/ -region eu-central-1
```

### Via AWS Systems Manager (SSM):


## Post-Deployment steps

- Restart SAP HANA e.g. HDB stop -> HDB start
- In HANA Stuio: Add Athena as Remote source

## TODO

- Implement Params
- Automated Test