# shadowsocks-client

## Intro

shadowsocks-client via [shadowsocks-libev[3.2.4]](https://github.com/shadowsocks/shadowsocks-libev), [privoxy](https://www.privoxy.org/)

- ss-local for socks5 proxy
- privoxy for forwarding socks5 to http proxy

## ss-client

```bash
docker run -dt --name ss-client --restart always -p 1080:1080 -p 8118:8118 -e SERVER_ADDR=<server> -e SERVER_PORT=<port> -e METHOD=<method> -PASSWORD=<password> paiyehsu/shadowsocks-client
```

## Usage

    [ss-local]
       SERVER_ADDR           Host name or IP address of your remote server.
       SERVER_PORT           Port number of your remote server.
       METHOD                Encrypt method: rc4-md5,
                             aes-128-gcm, aes-192-gcm, aes-256-gcm,
                             aes-128-cfb, aes-192-cfb, aes-256-cfb,
                             aes-128-ctr, aes-192-ctr, aes-256-ctr,
                             camellia-128-cfb, camellia-192-cfb,
                             camellia-256-cfb, bf-cfb,
                             chacha20-ietf-poly1305,
                             xchacha20-ietf-poly1305,
                             salsa20, chacha20 and chacha20-ietf.
                             The default cipher is chacha20.
       PASSWORD              Password of your remote server.
       LOCAL_ADDR            Port number of your local server.
       LOCAL_PORT            Password of your remote server.
       TIMEOUT               Socket timeout in seconds.
       ARGS                  Addional config.

    [privoxy]
       PRIVOXY_ADDR          Privoxy bind address.
       PRIVOXY_PORT          Privoxy bind port.
