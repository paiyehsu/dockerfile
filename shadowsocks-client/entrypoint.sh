#!/bin/bash

echo -e "\033[32m[start privoxy @ ${PRIVOXY_ADDR}:${PRIVOXY_PORT}]\033[0m"
sed -i "s/^\(listen-address \).*/\1${PRIVOXY_ADDR}:${PRIVOXY_PORT}/" /etc/privoxy/config
privoxy --no-daemon /etc/privoxy/config &

echo -e "\033[32m""[start shadowsocks client @ $SERVER_ADDR:$SERVER_PORT $LOCAL_ADDR:$LOCAL_PORT]""\033[0m"
ss-local \
      -s $SERVER_ADDR \
      -p $SERVER_PORT \
      -m $METHOD \
      -k ${PASSWORD} \
      -b $LOCAL_ADDR \
      -l $LOCAL_PORT \
      -t $TIMEOUT \
      $ARGS