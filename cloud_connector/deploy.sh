# !/bin/bash
echo "START"

echo "Install JAVA"

sudo mkdir /sapcc

cd /sapcc

sudo wget "https://tools.hana.ondemand.com/additional/sapjvm-8.1.055-linux-x64.rpm" --header "Cookie: eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt"

sudo rpm -i sapjvm-8.1.055-linux-x64.rpm

echo "Install SAP Cloud Connector"

sudo wget "https://tools.hana.ondemand.com/additional/sapcc-2.12.0.1-linux-x64.zip" --header "Cookie: eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt"

sudo unzip sapcc-2.12.0.1-linux-x64.zip

sudo rpm -i com.sap.scc-ui-2.12.0.1.x86_64.rpm

service scc_daemon status

echo "ALL DONE"