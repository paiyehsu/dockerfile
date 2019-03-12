FROM alpine:3.9

LABEL maintainer="paiyehsu <paiyehsu@gmail.com>"

ENV SS_VERSION 3.2.4
ENV SS_DOWNLOAD_URL https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${SS_VERSION}/shadowsocks-libev-${SS_VERSION}.tar.gz

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV METHOD      chacha20-ietf-poly1305
ENV PASSWORD=
ENV LOCAL_ADDR 0.0.0.0
ENV LOCAL_PORT 1080
ENV TIMEOUT     300
ENV ARGS --fast-open
ENV PRIVOXY_ADDR 0.0.0.0
ENV PRIVOXY_PORT 8118

RUN apk upgrade \
    && apk add bash libsodium \
    && apk add --virtual .build-deps \
       build-base \
       tar \
       curl \
       autoconf \
       automake \
       udns-dev \
       pcre-dev \
       udns-dev \
       c-ares-dev \
       mbedtls-dev \
       libsodium-dev \
       libev-dev \
       libtool \
       linux-headers \
       xmlto \
    && curl -sSLO ${SS_DOWNLOAD_URL} \
    && tar -zxf shadowsocks-libev-${SS_VERSION}.tar.gz \
    && (cd shadowsocks-libev-${SS_VERSION} \
    && ./configure \
        --prefix=/usr \
        --disable-documentation \
    && make install) \
    && run_deps="$( \
        scanelf --needed --nobanner /usr/bin/ss-* /usr/local/bin/obfs-* \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | xargs -r apk info --installed \
            | sort -u \
        )" \
    && apk add --virtual .run-deps $run_deps \
    && apk del .build-deps \
    && rm -rf shadowsocks-libev-${SS_VERSION}.tar.gz \
       shadowsocks-libev-${SS_VERSION} \
       /var/cache/apk/*

RUN apk add privoxy \
    && echo "forward-socks5 / 127.0.0.1:1080 ." >> /etc/privoxy/config

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
