#
# an privileged container, converting unicast to multicast
#

FROM openshift/origin-base

RUN INSTALL_PKGS="socat iputils" && \
    yum install -y $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all

ADD mcast-converter.sh /bin/mcast-converter.sh

ENTRYPOINT /bin/mcast-router.sh
