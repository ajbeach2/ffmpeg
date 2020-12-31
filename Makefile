VERSION=go1.15.6-ffmpeg4.3.1
FFMPEG_VERSION=4.3.1

build:
	docker build --build-arg FFMPEGVERSION=$(FFMPEG_VERSION) -t $(repo)/ffmpeg:$(VERSION) .  && \
	docker push $(repo)/ffmpeg:$(VERSION)

http:
	docker run -it -v "$(shell pwd):/code" $(repo)/ffmpeg:$(VERSION) \
		ffmpeg -v 9 -loglevel 99 -i "https://mp3d.jamendo.com/?trackid=1297521&format=mp32&from=app-97dab294" \
			-filter_complex \
				"[0:a]aformat=channel_layouts=mono,compand=gain=-6, \
				showwavespic=s=600x120:colors=white,negate[a]; \
				color=black:600x120[c]; \
				[c][a]alphamerge" -vframes 1 /code/song.png \
			-map 0:a -map -0:v -c:a libfdk_aac -b:a 256k -single_file 1 -f dash /code/song.mpd
