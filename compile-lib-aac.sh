mkdir ~/ffmpeg_sources
mkdir ~/ffmpeg_build
mkdir ~/bin

cd ~/ffmpeg_sources
git clone https://github.com/mstorsjo/fdk-aac.git
cd fdk-aac
git checkout v2.0.2
autoreconf -fiv
./configure --prefix="$HOME/ffmpeg_build" --disable-shared --enable-static
make
make install
make distclean