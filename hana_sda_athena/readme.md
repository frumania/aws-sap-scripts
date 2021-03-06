# Overview

Automatically configure SLES OS to allow AWS Athena as remote data source for SAP HANA. Based on
https://aws.amazon.com/de/blogs/awsforsap/run-federated-queries-to-an-aws-data-lake-with-sap-hana/

## Prerequisites:

- SLES OS 64bit
- SAP HANA
- Assigned EC2 instance role with policy "AmazonAthenaFullAccess" or similar.
- S3 bucket to store logs

## Deployment

### Manually:

```bash
$ chmod 700 deploy.sh
$ ./deploy.sh s3://<bucket>/ <region>
```

e.g.

```bash
$ ./deploy.sh s3://aws-athena-hana-int/logs/ eu-central-1
```


### Via AWS Systems Manager (SSM):

1) Choose: AWS-RunRemoteScript
2) Source Type: GitHub
3) Source Info:
```json
{
"owner":"frumania",
"repository":"aws-sap-scripts",
"path":"hana_sda_athena"
}
```
4) Command Line: deploy.sh s3://\<bucket\>/ \<region\>

## Post-Deployment steps

- In HANA Studio/Cockpit: Add Athena as Remote source (user & pw can be arbitary = dummy values only)

![image](https://d2908q01vomqb2.cloudfront.net/17ba0791499db908433b80f37c5fbc89b870084b/2018/09/07/image016.png)

## Todo

n/a