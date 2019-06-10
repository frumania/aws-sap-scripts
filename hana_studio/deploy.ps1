mkdir c:\tmp
cd /tmp
Read-S3Object -BucketName sap-sources -KeyPrefix HANA_CLIENT/HANA_STUDIO -Folder /tmp

amazon-corretto-8.212.04.2-windows-x64.msi /qn /L* "C:\tmp\install.log" /norestart ALLUSERS=2

sleep 60

[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Amazon Corretto\jdk1.8.0_212")
[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$($Env:JAVA_HOME)\bin", "User")

Expand-Archive -Path c:\tmp\eclipse-java-2019-03-R-win32-x86_64.zip -DestinationPath c:\tmp\

cd /tmp/eclipse

.\eclipse.exe -nosplash \
  -application org.eclipse.equinox.p2.director \
  -repository http://download.eclipse.org/releases/indigo/,http://download.eclipse.org/tools/cdt/releases/helios/ \
  -destination C:\tmp\eclipse\eclipse \
  -installIU org.eclipse.cdt.feature.group \
  -installIU org.eclipse.cdt.sdk.feature.group \
  -installIU org.eclipse.cdt.platform.feature.group \
  -installIU org.eclipse.cdt.debug.ui.memory.feature.group \
  -installIU org.eclipse.cdt.debug.edc.feature.group \
  -installIU org.eclipse.cdt.util.feature.group

.\eclipse.exe -nosplash -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/indigo/,http://download.eclipse.org/tools/cdt/releases/helios/ -destination C:\tmp\eclipse\eclipse -installIU org.eclipse.cdt.feature.group