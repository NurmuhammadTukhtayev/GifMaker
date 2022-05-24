#!/bin/bash

if [[ -z $1 ]] ; then
    echo 'input video file name(full path)'
    exit 1
fi

if [[ -z $2 ]] ; then
    echo 'input output gif file name'
    exit 1
fi

# 30:46 (946)  -> 1846 in program
skip_seconds=4315.8 # skip first N second
output_lenght=1.2 # output lenght N second
fps=10          # N frames per second
image_width=720 #N pixels wide and automatically determine the height while preserving the aspect ratio

ffmpeg -y -ss $skip_seconds -t $output_lenght -i "$1" -vf fps=$fps,scale=$image_width:-1:flags=lanczos,palettegen palette.png
ffmpeg -ss    $skip_seconds -t $output_lenght -i "$1" -i palette.png -filter_complex "fps=$fps,scale=$image_width:-1:flags=lanczos[x];[x][1:v]paletteuse" "$2"

rm palette.png
# 16: 15 5
