# !/bin/bash
echo "START"
BUCKET=$1
REGION=$2

echo "Install unixODBC"

sudo zypper install -y unixODBC

echo "Install AthenaODBC"

sudo mkdir /AthenaODBC

cd /AthenaODBC

sudo wget https://s3.amazonaws.com/athena-downloads/drivers/ODBC/SimbaAthenaODBC_1.0.5/Linux/simbaathena-1.0.5.1006-1.x86_64.rpm

sudo zypper --no-gpg-checks install -y simbaathena-1.0.5.1006-1.x86_64.rpm

echo "Create .odbc.ini"

cd /usr/sap/HDB/home

sudo cat > .odbc.ini <<EOF
[Data Sources]
MyDSN=Simba Athena ODBC Driver 64-bit
[MyDSN]
Driver=/opt/simba/athenaodbc/lib/64/libathenaodbc_sb64.so
AuthenticationType=Instance Profile
AwsRegion=$2
S3OutputLocation=$1
EOF

sudo chmod 700 .odbc.ini

sudo chown hdbadm:sapsys .odbc.ini

echo "Create .customer.sh"

sudo cat > .customer.sh <<EOF
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/simba/athenaodbc/lib/64/
export ODBCINI=$HOME/.odbc.ini
EOF

sudo chmod 700 .customer.sh

sudo chown hdbadm:sapsys .customer.sh

echo "Test Connection"

sudo -u hdbadm isql MyDSN -c -d
quit

echo "Create Property_Athena.ini"

cd /usr/sap/HDB/SYS/exe/hdb/config

sudo cat > Property_Athena.ini <<EOF
CAP_SUBQUERY : true
CAP_ORDERBY : true
CAP_JOINS : true
CAP_GROUPBY : true
CAP_AND : true
CAP_OR : true
CAP_TOP : false
CAP_LIMIT : true
CAP_SUBQUERY :  true
CAP_SUBQUERY_GROUPBY : true

FUNC_ABS : true
FUNC_ADD : true
FUNC_ADD_DAYS : DATE_ADD(DAY,\$2,\$1)
FUNC_ADD_MONTHS : DATE_ADD(MONTH,\$2,\$1)
FUNC_ADD_SECONDS : DATE_ADD(SECOND,\$2,\$1)
FUNC_ADD_YEARS : DATE_ADD(YEAR,\$2,\$1)
FUNC_ASCII : true
FUNC_ACOS : true
FUNC_ASIN : true
FUNC_ATAN : true
FUNC_TO_VARBINARY : false
FUNC_TO_VARCHAR : false
FUNC_TO_NVARCHAR : CAST(\$1 AS varchar)
FUNC_TO_INT : CAST(\$1 AS integer)
FUNC_TO_DECIMAL : CAST (\$1 AS double) 
FUNC_TRIM_BOTH : TRIM(\$1)         
FUNC_TRIM_LEADING : LTRIM(\$1)
FUNC_TRIM_TRAILING : RTRIM(\$1)
FUNC_UMINUS : false
FUNC_UPPER : true  
FUNC_WEEKDAY : false

TYPE_TINYINT : TINYINT
TYPE_LONGBINARY : VARBINARY
TYPE_LONGCHAR : VARBINARY
TYPE_DATE : DATE
TYPE_TIME : TIME
TYPE_DATETIME : TIMESTAMP
TYPE_REAL : REAL
TYPE_SMALLINT : SMALLINT
TYPE_INT : INTEGER
TYPE_INTEGER : INTEGER
TYPE_FLOAT : DOUBLE
TYPE_CHAR : CHAR(\$PRECISION)
TYPE_BIGINT : DECIMAL(19,0)
TYPE_DECIMAL : DECIMAL(\$PRECISION,\$SCALE)
TYPE_VARCHAR : VARCHAR(\$PRECISION)
TYPE_BINARY : VARBINARY
TYPE_VARBINARY : VARBINARY
TYPE_NVARCHAR : STRING

PROP_USE_UNIX_DRIVER_MANAGER : true
EOF

sudo chmod 444 Property_Athena.ini

sudo chown hdbadm:sapsys Property_Athena.ini

echo "ALL DONE"