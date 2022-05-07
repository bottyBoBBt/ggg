FROM alpine:3.6

ENV VER=2.11.1 METHOD=AEAD_CHACHA20_POLY1305 PASSWORD=ss123456
ENV TLS_PORT=4433

RUN apk add --no-cache curl \
  && curl -sL https://github.com/xiaokaixuan/gost-heroku/releases/download/v${VER}/gost_${VER}_linux_amd64.tar.gz | tar zx \
  && mv gost_${VER}_linux_amd64 gost && chmod a+x gost/gost

WORKDIR /gost
EXPOSE ${TLS_PORT}

CMD exec /gost/gost -L=ss+mwss://$METHOD:$PASSWORD@:$TLS_PORT

