# !/bin/bash
set -e

echo "Test Cloud Connector"
aws ssm send-command --document-name "AWS-RunRemoteScript" --document-version "1" --targets "Key=instanceids,Values=i-0496ed2f5e2b0ac53" --parameters '{"sourceType":["GitHub"],"sourceInfo":["{\n\"owner\":\"frumania\",\n\"repository\":\"aws-sap-scripts\",\n\"path\":\"cloud_connector\"\n}"],"commandLine":["deploy.sh"],"workingDirectory":[""],"executionTimeout":["3600"]}' --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --output-s3-bucket-name "serverlesswsmarcel" --region eu-central-1