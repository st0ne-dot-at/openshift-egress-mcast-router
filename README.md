# openshift-egress-mulicast
The

add privileged serviceaccount
-----------------------------

    oc create serviceaccount mcast-router

Edit the SecurityContextConstraint privileged and add the newly created serviceaccount

    oc edit scc privileged 

add:

    - system:serviceaccount:default:mcast-router

check:

    oc get scc privileged  -o yaml

import template
---------------

    oc create -f https://raw.githubusercontent.com/st0ne-dot-at/openshift-egress-mcast-router/master/openshift/templates/egress-mcast-router.yaml

create multicast router from template
----------------------------------------

    oc process -n openshift egress-mcast-router \
        -vNAME=my-5007-mcast-router \
        -vMULTICAST_PORT=5007 \
        -vVERBOSE=true \
        -vPRIVILEGED_SERVICEACCOUNT=mcast-router | oc create -f -

cleanup
-------

    n=my-5007-mcast-router; oc delete service ${n}-mcr ; oc delete imagestream ${n}-mcr ; oc delete deploymentconfig ${n}-mcr ; oc delete buildconfig ${n}-mcr
