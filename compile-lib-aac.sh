mkdir ~/ffmpeg_sources
mkdir ~/ffmpeg_build
mkdir ~/bin

cd ~/ffmpeg_sources
git clone --branch v0.1.5 https://github.com/mstorsjo/fdk-aac.git
cd fdk-aac
autoreconf -fiv
./configure --prefix="$HOME/ffmpeg_build" --disable-shared --enable-static
make
make install
make distclean