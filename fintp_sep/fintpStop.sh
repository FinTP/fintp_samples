. ./fintpSetEnv.sh
. ./fintpUtil.sh

echo "Stopping Connectors"

for service in $FINTPCONNECTORSSTOP ; do
	stop_service $FINTPCONNECTORSPATH $service
done


echo "Stopping Core Services"

for service in $FINTPCORESTOP ; do
stop_service $FINTPCOREPATH $service
done



echo
echo "Done"
