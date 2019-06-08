# !/bin/bash
echo "START"

BUCKET=$1
PASS=$2

echo "Download files"

mkdir /hana/shared/tmp_hana_cockpit

cd /hana/shared/tmp_hana_cockpit

aws s3 sync $BUCKET /hana/shared/tmp_hana_cockpit

echo "Extract SAR"

sudo chmod 777 SAPCAR.EXE

sudo ./SAPCAR.EXE -xvf "SAPHANACOCKPIT.SAR"

sudo chmod 700 hdblcm.sh

echo "Install SAP HANA Cockpit (standalone=2)"

sudo printf '2\n\n\n\n\n$PASS\n$PASS\ny\n' | ./hdblcm.sh -ignore check_signature_file

echo "ALL DONE"