# !/bin/bash
echo "START"
KEY=$1
SECRET=$2
REGION=$3

sudo printf '$KEY\n$SECRET\n$REGION\n\n\n' | aws configure

echo "Prep"

mkdir /hana
mkdir /hana/shared
mkdir /usr
mkdir /usr/sap
mkdir /usr/sap/HDB
mkdir /usr/sap/HDB/home
mkdir /usr/sap/HDB/SYS
mkdir /usr/sap/HDB/SYS/exe
mkdir /usr/sap/HDB/SYS/exe/hdb
mkdir /usr/sap/HDB/SYS/exe/hdb/config

sudo groupadd sapsys
sudo adduser hdbadm sapsys

echo "Test Cloud Connector"

cd cloud_connector
chmod 700 deploy.sh
./deploy.sh
cd ..

echo "Test SDA Athena"

cd hana_sda_athena
chmod 700 deploy.sh
./deploy.sh s3://aws-athena-hana-int/logs/ eu-central-1
more /usr/sap/HDB/SYS/exe/hdb/config/Property_Athena.ini
cd ..

#echo "Test HANA COCKPIT"

#cd hana_cockpit
#chmod 700 deploy.sh
#./deploy.sh s3://sap-sources/HANA_CLIENT/HANA_COCKPIT/ MyHanaCP123#
#cd ..

echo "ALL DONE"