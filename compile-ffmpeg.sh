cd ~/ffmpeg_sources
wget http://ffmpeg.org/releases/ffmpeg-$FFMPEGVERSION.tar.bz2
tar xjvf ffmpeg-$FFMPEGVERSION.tar.bz2
cd ffmpeg-$FFMPEGVERSION
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --bindir="$HOME/bin" \
  --disable-doc \
  --disable-ffplay \
  --disable-ffprobe \
  --enable-protocol="https" \
  --enable-protocol="http" \
  --enable-protocol="file" \
  --enable-protocol="pipe" \
  --enable-protocol="tls_openssl" \
  --enable-openssl \
  --enable-gpl \
  --enable-nonfree \
  --enable-version3 \
  --enable-libfdk-aac \
  --enable-nonfree \
  --enable-pthreads
PATH="$HOME/bin:$PATH" make
make install
make distclean
hash -r

ln -s "$HOME/bin/ffmpeg" /usr/bin/ffmpeg