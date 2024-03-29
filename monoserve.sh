#!/bin/sh

### BEGIN INIT INFO
# Provides:          monoserve.sh
# Required-Start:    $local_fs $syslog $remote_fs
# Required-Stop:     $local_fs $syslog $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start fastcgi mono server with hosts
### END INIT INFO

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/usr/local/bin/mono
NAME=monoserver
DESC=monoserver

MONOSERVER=$(which fastcgi-mono-server2)
MONOSERVER_PID=$(ps auxf | grep fastcgi-mono-server2.exe | grep -v grep | awk '{print $2}')

#WEBAPPS="www.domain1.xyz:/:/var/www/domain1.xyz/,www.domain2.xyz:/:/var/www/domain2.xyz/"
WEBAPPS="mx.reymundolopez.com:/:/var/www/nxtms.mx/public_html/"

case "$1" in
        start)
                if [ -z "${MONOSERVER_PID}" ]; then
                        echo "starting mono server"
                        ${MONOSERVER} /applications=${WEBAPPS} /socket=tcp:127.0.0.1:9001 &
                        echo "mono server started"
                else
                        echo ${WEBAPPS}
                        echo "mono server is running"
                fi
        ;;
        stop)
                if [ -n "${MONOSERVER_PID}" ]; then
                        kill ${MONOSERVER_PID}
                        echo "mono server stopped"
                else
                        echo "mono server is not running"
                fi
        ;;
esac

exit 0