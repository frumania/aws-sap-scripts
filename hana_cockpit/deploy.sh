# !/bin/bash
echo "START"

BUCKET=$1
PASS=$2

echo "Download files"

mkdir /usr/sap/tmp_hana_cockpit

cd /usr/sap/tmp_hana_cockpit

aws s3 sync $BUCKET /usr/sap/tmp_hana_cockpit

echo "Extract SAR"

sudo ./SAPCAR.EXE -xvf "SAPHANACOCKPIT10_6-70002299.SAR"

sudo chmod 700 hdblcm.sh

echo "Install SAP HANA Cockpit (standalone=2)"

sudo printf '2\n\n\n\n\n$PASS#\n$PASS\ny\n' | ./hdblcm.sh -ignore check_signature_file

echo "ALL DONE"