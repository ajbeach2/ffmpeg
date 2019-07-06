VERSION=0.1.0

build:
	docker build --build-arg FFMPEGVERSION=$(ffmpeg) -t ajbeach2/ffmpeg:$(ffmpeg) .

http:
	docker run -it -v "$(shell pwd):/code" ajbeach2/ffmpeg:$(tag) \
		ffmpeg -v 9 -loglevel 99 -i "https://s3.amazonaws.com/dev-kantoio/site/song.mp3" \
			-filter_complex \
				"[0:a]aformat=channel_layouts=mono,compand=gain=-6, \
				showwavespic=s=600x120:colors=white,negate[a]; \
				color=black:600x120[c]; \
				[c][a]alphamerge" -vframes 1 /code/song.png \
			-map 0:a -map -0:v -c:a libfdk_aac -b:a 256k -single_file 1 -f dash /code/song.mpd
all:
	for ffmpeg in "snapshot-git" "4.1.3"; do \
		docker build --build-arg FFMPEGVERSION=$$ffmpeg -t ajbeach2/ffmpeg:$$ffmpeg . ; \
		docker push ajbeach2/ffmpeg:$$ffmpeg; \
	done

tag:
	docker tag ajbeach2/ffmpeg:snapshot-git ajbeach2/ffmpeg:$(VERSION) && \
	docker push ajbeach2/ffmpeg:$(VERSION)
