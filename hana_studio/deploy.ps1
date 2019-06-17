echo "START"
$ErrorActionPreference = "Stop"

$mypath = "c:/eclipse2018-12"
If(!(test-path $mypath))
{
      New-Item -ItemType Directory -Force -Path $mypath
}

cd $mypath

echo "Downloading Amazon Corretto..."
$url = "https://d3pxv6yz143wms.cloudfront.net/8.212.04.2/amazon-corretto-8.212.04.2-1-windows-x64.msi"
$output = $mypath+"/amazon-corretto-8.212.04.2-1-windows-x64.msi"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
echo "...done!"
echo "Installing Amazon Corretto..."
.\amazon-corretto-8.212.04.2-1-windows-x64.msi /qn /L* "install.log" /norestart ALLUSERS=2
echo "...done!"

sleep 60

echo "Set JAVA HOME..."
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Amazon Corretto\jdk1.8.0_212")
[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$($Env:JAVA_HOME)\bin", "User")
#java -version
echo "...done!"

echo "Downloading Eclipse..."
$url = "http://ftp.halifax.rwth-aachen.de/eclipse//technology/epp/downloads/release/2018-12/R/eclipse-java-2018-12-R-win32-x86_64.zip"
$output = $mypath+"/eclipse-java-2018-12-R-win32-x86_64.zip"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
echo "...done!"
echo "Installing Eclipse..."
Expand-Archive -Path eclipse-java-2018-12-R-win32-x86_64.zip -DestinationPath $mypath
echo "...done!"

cd eclipse

dir

echo "Installing SAP HANA Studio Plugin for Eclipse..."

#.\eclipse -nosplash -consoleLog -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/2018-12 -installIU "org.eclipse.emf.transaction,org.eclipse.zest.core,org.eclipse.zest.core,org.eclipse.draw2d.feature.group,org.eclipse.emf.common.ui.feature.group,org.eclipse.emf.databinding.feature.group,org.eclipse.emf.ecore.edit.feature.group,org.eclipse.emf.edit.feature.group,org.eclipse.emf.edit.ui.feature.group,org.eclipse.gef.feature.group,org.eclipse.zest.feature.group,org.eclipse.ui.trace,javax.mail,org.apache.commons.collections,org.eclipse.graphiti,org.eclipse.graphiti.ui,org.eclipse.wst.web_ui.feature.feature.group,org.eclipse.emf.feature.group,org.eclipse.emf.transaction.feature.group,org.eclipse.emf.validation.feature.group,org.eclipse.emf.workspace.feature.group,org.eclipse.graphiti.feature.feature.group,org.eclipse.xpand.feature.group,org.eclipse.xtend.ui.feature.group"
#.\eclipse -nosplash -consoleLog -application org.eclipse.equinox.p2.director -repository https://tools.hana.ondemand.com/2018-12 -list
#.\eclipse -nosplash -consoleLog -application org.eclipse.equinox.p2.director -repository "https://tools.hana.ondemand.com/2018-12,http://download.eclipse.org/releases/2018-12" -installIU HANATools

$myeclipsepath = $mypath+"/eclipse/eclipse.exe";
Start-Process -NoNewWindow -FilePath $myeclipsepath -ArgumentList "-nosplash -consoleLog -application org.eclipse.equinox.p2.director -repository https://tools.hana.ondemand.com/2018-12,http://download.eclipse.org/releases/2018-12 -installIU HANATools"

sleep 360

echo "...done!"

#Output install log
echo "Output install log:"
$conf = $mypath+"/eclipse/configuration/";
$files = get-childitem -Filter *.log $conf
foreach ($file in $files)
{
  Get-Content -Path $file.Fullname
}

#Check Plugins
$conf = $mypath+"/eclipse/plugins/";
$files = get-childitem -Filter *com.sap.ndb.studio*.jar $conf

if($files.Length -eq 0)
{throw "No SAP HANA plugins found. Installation must have failed!"}
else{Write-Host "SAP HANA Plugins found:" $files.Length}

echo "Create Shortcut..."

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("C:\Users\Public\Desktop\eclipse.lnk")
$Shortcut.TargetPath = $mypath+"/eclipse/eclipse.exe"
$Shortcut.Save()

echo "...done!"

echo "ALL DONE"