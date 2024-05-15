#!/bin/sh

# User defined variables
#TEID_N3_UPF
#TEID_N3_GNB
#N3_UPF_IP
#N6_APP_SERVER_IP
#N6_APP_SERVER_SUBNET

# Pre-defined variables
IP_VERSION="ip"
MTU=1500
GTP_DEV="ue-tun"

function log {
    echo -e "[INFO] $1"
    sleep 1
}

function start {
    log "create gtp devices (run in bg mode)"
    ./gtp-link add $GTP_DEV $IP_VERSION &

    log "configure mtu of gtp devices"
    ip link set mtu $MTU dev $GTP_DEV

    log "create gtp tunnel: [TEID_N3_GNB=$TEID_N3_GNB, TEID_N3_UPF=$TEID_N3_UPF, \
        N3_UPF_IP=$N3_UPF_IP, N6_APP_SERVER_IP=$N6_APP_SERVER_IP]"
    ./gtp-tunnel add $GTP_DEV v1 $TEID_N3_UPF $TEID_N3_GNB $N6_APP_SERVER_IP $N3_UPF_IP
    log "$(./gtp-tunnel list)"

    log "configure routes using gtp devices"
    ip route add $N6_APP_SERVER_SUBNET dev $GTP_DEV
}

start
sleep infinity
