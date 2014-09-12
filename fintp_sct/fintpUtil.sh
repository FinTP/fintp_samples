# FinTP - Financial Transactions Processing Application
# Copyright (C) 2013 Business Information Systems (Allevo) S.R.L.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>
# or contact Allevo at : 031281 Bucuresti, 23C Calea Vitan, Romania,
# phone +40212554577, office@allevo.ro <mailto:office@allevo.ro>, www.allevo.ro.


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
