FROM golang:1.12.6-alpine3.10
RUN mkdir /root/scripts

RUN apk update && apk --no-cache add \
    build-base wget \
    pkgconf \
    libpthread-stubs \
    git \
    openssl \
    openssl-dev \
    pkgconfig \
    autoconf \
    automake \
    libass-dev \
    libtheora-dev \
    libtool \
    libvorbis-dev \
    texinfo \
    zlib-dev \
    yasm \
    freetype-dev

ADD compile-lib-aac.sh /root/scripts
RUN ~/scripts/compile-lib-aac.sh

ARG FFMPEGVERSION
ADD compile-ffmpeg.sh /root/scripts/
RUN ~/scripts/compile-ffmpeg.sh

FROM golang:1.12.6-alpine3.10
COPY --from=0 /root/bin /root/bin
RUN apk add --update \
ca-certificates \
libass-dev \
libtheora-dev \
libtool \
openssl \
libvorbis-dev \
zlib-dev \
x264-dev && \
ln -s /root/bin/ffmpeg /usr/bin/ffmpeg

