FROM alpine:3.19 as buildenv

RUN apk add --no-cache git ca-certificates \
	libmnl-dev build-base make automake autoconf libtool pkgconfig

RUN git clone https://gitea.osmocom.org/cellular-infrastructure/libgtpnl \
	&& cd /libgtpnl && autoreconf -fi && ./configure && make

FROM alpine:3.19

WORKDIR /nf-gtp-gw

COPY --from=buildenv /libgtpnl/src/.libs/libgtpnl.so* /usr/lib/
COPY --from=buildenv /libgtpnl/tools/.libs/* .
COPY ./startup.sh ./

RUN apk add --no-cache libmnl iproute2 \
	&& ldconfig /

ENV TEID_N3_GNB=100 \
    TEID_N3_UPF=200 \
    N3_UPF_IP=127.0.0.1 \
    N6_APP_SERVER_IP=127.0.0.2 \
    N6_APP_SERVER_SUBNET=127.0.0.0/8

ENTRYPOINT ["./startup.sh"]
