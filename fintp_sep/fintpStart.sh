. ./fintpSetEnv.sh
. ./fintpUtil.sh



echo "Satrting FinTP Core Services"

for service in $FINTPCORESTART ; do
	start_service $FINTPCOREPATH $service
done 

echo "Starting FinTP Connectors"

for service in $FINTPCONNECTORSSTART ; do
	start_service $FINTPCONNECTORSPATH $service
done

echo "Output for every daemon will be in *out"
echo "Done."
