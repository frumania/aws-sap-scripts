
mkdir c:\tmp
cd /tmp
Read-S3Object -BucketName sap-sources -KeyPrefix HANA_CLIENT/HANA_STUDIO -Folder /tmp
.\jre-8u211-windows-x64.exe /s

Start-Process 'C:\tmp\jre-8u211-windows-x64.exe' -ArgumentList 'INSTALL_SILENT=Enable REBOOT=Disable SPONSORS=Disable' -Wait -PassThru



$text='
INSTALL_SILENT=Enable
AUTO_UPDATE=Enable
SPONSORS=Disable
REMOVEOUTOFDATEJRES=1
'
$text | Set-Content "c:\tmp\jreinstall.cfg"

Start-Process -FilePath "c:\tmp\jre-8u211-windows-x64.exe" -ArgumentList INSTALLCFG="c:\tmp\jreinstall.cfg"
