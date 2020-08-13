FROM ubuntu:16.04

WORKDIR /app
USER root

RUN apt-get update
RUN apt-get --assume-yes install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev
RUN apt-get --assume-yes install automake libtool autoconf

RUN git clone https://github.com/xmrig/xmrig.git
WORKDIR /app/xmrig

RUN mkdir build
WORKDIR /app/xmrig/build
RUN cmake .. -DXMRIG_DEPS=scripts/deps
RUN make -j$(nproc)

CMD ./xmrig -c $XMRIG_JSON_CONFIG_PATH

