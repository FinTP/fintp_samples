# Function start_service
#  Usage: start_service arg1 arg2 arg3 arg4
#    arg1 is the starting path
#    arg2 is the name of the process

start_service(){
	PID=`ps -ef|grep $1\/$2|grep -v grep|awk '{ print $2 }'`
	if [ -z "$PID" ]; then
		echo "	Starting $2"
		cd $1
		$1\/$2 > $FINTPLOGDIR/$2.out 2>&1 &
		sleep 1
	else 
		echo "	$2 is already started, PID is $PID"
	fi
}

stop_service(){
	typeset count
	typeset timeout
	PID=`ps -ef|grep $1\/$2|grep -v grep|awk '{ print $2 }'`
	if [ -z "$PID" ]; then
		echo "	$2 is already stopped"
	else 
		echo "	Stopping $2, PID is $PID"
	    kill -s INT $PID
		if [ -n "$PID" ]; then
		    printf "	Waiting for $2 to stop.\n"
		    count=0
		    while [ -n "$PID" ];  do
				if [[ $count -eq "20" ]]; then
			    	echo
				    count=0
				    timeout=0
			    else
				    printf "."
				    sleep 1
				fi
				(( count = $count + 1))
				(( timeout = $timeout + 1))
				if [ $timeout -gt $FINTPSTOPTIMEOUT ] ; then
					echo "	$2 did not stop in $FINTPSTOPTIMEOUT seconds. Killing the process." 
					kill -9 $PID
					return
				fi
				PID=`ps -ef|grep $1\/$2|grep -v grep|awk '{ print $2 }'`
		    done
		    echo
		fi
	fi
}

service_status(){
	PID=`ps -ef|grep $1\/$2|grep -v grep|awk '{ print $2 }'`
	if [ -z "$PID" ]; then
		echo "	$2 is not running."
	else 
		echo "	$2 is running, PID is $PID"
	fi
}
