# !/bin/bash
set -e

echo "Boot Instance"
instance_id=$(aws ec2 run-instances --launch-template LaunchTemplateId=lt-0224bf3ab77c362a2,Version=4 --query 'Instances[].[InstanceId]' --output text)
echo $instance_id

echo "Wait 5 min"
sleep 360

echo "Test Cloud Connector"
aws ssm send-command --document-name "AWS-RunRemoteScript" --document-version "1" --targets "Key=instanceids,Values=$instance_id" --parameters '{"sourceType":["GitHub"],"sourceInfo":["{\n\"owner\":\"frumania\",\n\"repository\":\"aws-sap-scripts\",\n\"path\":\"cloud_connector\"\n}"],"commandLine":["deploy.sh"],"workingDirectory":[""],"executionTimeout":["3600"]}' --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --output-s3-bucket-name "aws-ssm-instance-logs" --region eu-central-1

echo "Test HANA SDA Athena"
aws ssm send-command --document-name "AWS-RunRemoteScript" --document-version "1" --targets "Key=instanceids,Values=$instance_id" --parameters '{"sourceType":["GitHub"],"sourceInfo":["{\n\"owner\":\"frumania\",\n\"repository\":\"aws-sap-scripts\",\n\"path\":\"hana_sda_athena\"\n}"],"commandLine":["deploy.sh s3://aws-athena-hana-int/logs/ eu-central-1"],"workingDirectory":[""],"executionTimeout":["3600"]}' --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --output-s3-bucket-name "aws-ssm-instance-logs" --region eu-central-1

echo "Terminate Instance"
aws ec2 terminate-instances --instance-ids $instance_id