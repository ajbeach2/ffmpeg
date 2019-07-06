# FFMPEG Go 1.12, Alpine 3.10, FFMPEG

[![Release](https://img.shields.io/github/release/ajbeach2/ffmpeg.svg)](https://github.com/ajbeach2/ffmpeg/releases)

## Building

The repo will build a specific version of ffmpeg on alpine. Optionall, `make all` will build all versions in the makefile. See Makefile for more details.


### Examples:
```
make ffmpeg=snapshot-git build
make ffmpeg=4.3.1 build
make all
```

## Testing

The following command will run a sample command against a docker tag of this repo.

```
make tag=0.1.0 http
```