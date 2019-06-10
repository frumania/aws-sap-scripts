cd /tmp
Read-S3Object -BucketName sap-sources -KeyPrefix SAP_GUI -Folder /tmp

NwSapSetup.exe /Package:"SAPGUI740" /noDlg

sleep 60