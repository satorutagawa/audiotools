#!/bin/bash -x
set -e

input_file=${1}
orig_tempo=${2}
new_tempo=${3}

filename=$(basename -- "$input_file")
extension="${filename##*.}"
filename="${filename%.*}"
outfile="${filename}.${new_tempo}.${extension}"

ratio=$(echo print ${new_tempo}/${orig_tempo}. | python)

#ffmpeg -i "${input_file}" -f:a atempo="${ratio}" "${outfile}"
ffmpeg -i "${input_file}" -filter:audio atempo="${ratio}" -vn "${outfile}"
echo "Wrote to ${outfile}"
