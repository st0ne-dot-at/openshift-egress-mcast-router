# openshift-egress-mulicast


create from commandline
=======================

    oc process -n openshift egress-mcast-router -vNAME=nix,MULTICAST_PORT=5007,VERBOSE=true,PRIVILEGED_SERVICEACCOUNT=ipfailover | oc create -f -
