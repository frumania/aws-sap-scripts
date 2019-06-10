
mkdir c:\tmp
cd /tmp
Read-S3Object -BucketName sap-sources -KeyPrefix HANA_CLIENT/HANA_STUDIO -Folder /tmp
.\jre-8u211-windows-x64.exe /s