FROM node:14.15.0-alpine

WORKDIR /stremio

ARG VERSION=master

RUN apk add --no-cache openssl-dev wget ffmpeg
RUN wget https://dl.strem.io/four/${VERSION}/server.js
RUN wget https://dl.strem.io/four/${VERSION}/stremio.asar

# apply patch to skip CORS headers verification
# see: https://github.com/sleeyax/stremio-streaming-server/issues/5
RUN sed -i 's/if (ok) enginefs.sendCORSHeaders/if (true) enginefs.sendCORSHeaders/g' server.js

VOLUME ["/root/.stremio-server"]

EXPOSE 11470

ENTRYPOINT [ "node", "server.js" ]
