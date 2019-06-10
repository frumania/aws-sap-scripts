mkdir c:\tmp
cd /tmp
Read-S3Object -BucketName sap-sources -KeyPrefix HANA_CLIENT/HANA_STUDIO -Folder /tmp

amazon-corretto-8.212.04.2-windows-x64.msi /qn /L* "C:\tmp\install.log" /norestart ALLUSERS=2

sleep 60

[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Amazon Corretto\jdk1.8.0_212")
[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$($Env:JAVA_HOME)\bin", "User")

sudo /usr/local/eclipse/eclipse -nosplash \
  -application org.eclipse.equinox.p2.director \
  -repository http://download.eclipse.org/releases/indigo/,http://download.eclipse.org/tools/cdt/releases/helios/ \
  -destination /usr/local/eclipse \
  -installIU org.eclipse.cdt.feature.group \
  -installIU org.eclipse.cdt.sdk.feature.group \
  -installIU org.eclipse.cdt.platform.feature.group \
  -installIU org.eclipse.cdt.debug.ui.memory.feature.group \
  -installIU org.eclipse.cdt.debug.edc.feature.group \
  -installIU org.eclipse.cdt.util.feature.group