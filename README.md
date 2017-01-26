# openshift-egress-mulicast


create multicast router from commandline
----------------------------------------

    oc process -n openshift egress-mcast-router \
        -vNAME=nix,MULTICAST_PORT=5007,VERBOSE=true,PRIVILEGED_SERVICEACCOUNT=ipfailover | oc create -f -


cleanup
-------

    n=nix; oc delete service ${n}-mcr ; oc delete imagestream ${n}-mcr ; oc delete deploymentconfig ${n}-mcr ; oc delete buildconfig ${n}-mcr
