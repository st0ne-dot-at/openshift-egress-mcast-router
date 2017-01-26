#!/bin/sh

set -ex

OPTS=""

if [ -z "${MULTICAST_DESTINATION}" ]; then
    echo "No multicast destination specified"
    exit 1
fi
if [ -z "${MULTICAST_PORT}" ]; then
    echo "No multicast port specified"
    exit 1
fi

if [ -z "${MULTICAST_TTL}" ]; then
    MULTICAST_TTL=10
fi

if [ "${VERBOSE}" == "true" ]; then
    OPTS="${OPTS} -v "
fi

socat ${OPTS} -u UDP-RECV:${MULTICAST_PORT} UDP-DATAGRAM:${MULTICAST_DESTINATION}:${MULTICAST_PORT},ip-multicast-ttl=${MULTICAST_TTL} &
SOCAT_PID=$!

IPTABLES_ID="${SOCAT_PID}$$"
echo iptables -I INPUT -p udp -s 10.1.0.0/16 --dport ${MULTICAST_PORT} -j ACCEPT -m comment --comment MCR_ID_${IPTABLES_ID}

trap "{ echo catched term signal; kill -9 $SOCAT_PID; iptables -D INPUT -p udp -s 10.1.0.0/16 --dport ${MULTICAST_PORT} -j ACCEPT -m comment --comment MCR_ID_${IPTABLES_ID}; exit 0; }" EXIT

echo "waiting for socat ($SOCAT_PID) to return"
wait $SOCAT_PID

