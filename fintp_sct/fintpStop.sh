. ./fintpSetEnv.sh
. ./fintpUtil.sh

echo "Stopping qPay Connectors"

for service in $FINTPCONNECTORSSTOP ; do
	stop_service $FINTPCONNECTORSPATH $service
done



echo
echo "Done"
