# openshift-egress-mcast-router
The egress-mcast-router runs a service that forwards incomming unicast udp traffic (from pods) to a specified destination multicast address (outside the cluster).

##Template Parameters
**MULTICAST_DESTINATION** ... multicast destination address (e.g. 239.255.200.68)

**MULTICAST_PORT**

**MULTICAST_TTL** ... sets the ttl of the outgoing multicast packets

**PRIVILEGED_SERVICEACCOUNT** ... a serviceaccount, that can run privileged containers





# Example
In the example the all udp packest sent to the service **my-5007-mcast-router-mcr.default.svc.cluster.local:5007** will be forwarded to the multicast address **239.255.200.68** on port **5007**.
### Step 1: add privileged serviceaccount

    oc create serviceaccount mcast-router

Edit the SecurityContextConstraint privileged and add the newly created serviceaccount

    oc edit scc privileged 

add:

    - system:serviceaccount:default:mcast-router

check:

    oc get scc privileged  -o yaml

### Step 2: import template

    oc create -f https://raw.githubusercontent.com/st0ne-dot-at/openshift-egress-mcast-router/master/openshift/templates/egress-mcast-router.yaml

### Step 3: create multicast router from template

    oc process -n openshift egress-mcast-router \
        -vNAME=my-5007-mcast-router \
        -vMULTICAST_PORT=5007 \
        -vVERBOSE=true \
        -vPRIVILEGED_SERVICEACCOUNT=mcast-router | oc create -f -

### Step 4: test
run from any pod in the cluster:

    echo woswasi1234 > /dev/udp/my-5007-mcast-router-mcr.default.svc.cluster.local/5007

###cleanup

    n=my-5007-mcast-router; oc delete service ${n}-mcr ; oc delete imagestream ${n}-mcr ; oc delete deploymentconfig ${n}-mcr ; oc delete buildconfig ${n}-mcr
