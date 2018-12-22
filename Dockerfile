FROM alpine:3.8
RUN mkdir /root/scripts
ENV FFMPEGVERSION 3.2

RUN apk --no-cache add \
    build-base wget \
    pkgconf \
    libpthread-stubs \
    git \
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

ADD compile-ffmpeg.sh /root/scripts/
RUN ~/scripts/compile-ffmpeg.sh

FROM alpine:3.7
COPY --from=0 /root/bin /root/bin
RUN apk add --update \
ca-certificates \
libass-dev \
libtheora-dev \
libtool \
libvorbis-dev \
zlib-dev \
x264-dev && \
ln -s /root/bin/ffmpeg /usr/bin/ffmpeg

