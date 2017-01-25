#!/bin/sh

set -ex

if [ -z "${MULTICAST_DESTINATION}" ]; then
    echo "No multicast destination specified"
    exit 1
fi
if [ -z "${MULTICAST_PORT}" ]; then
    echo "No multicast port specified"
    exit 1
fi

socat -u UDP-RECV:${MULTICAST_PORT} UDP-DATAGRAM:${MULTICAST_DESTINATION}:${MULTICAST_PORT}
