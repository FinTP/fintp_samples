. ./fintpSetEnv.sh
. ./fintpUtil.sh

echo "Status of FinTP Core Services"

for service in $FINTPCORESTART ; do
	service_status $FINTPCOREPATH $service
done 
echo "Status of FinTP Connectors"

for service in $FINTPCONNECTORSSTART ; do
	service_status $FINTPCONNECTORSPATH $service
done
