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


socat ${OPTS} -u UDP-RECV:${MULTICAST_PORT} UDP-DATAGRAM:${MULTICAST_DESTINATION}:${MULTICAST_PORT},ip-multicast-ttl=${MULTICAST_TTL}
