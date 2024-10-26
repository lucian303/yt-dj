#!/bin/bash

# Check if a URL is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <youtube_url>"
  exit 1
fi

# Download and convert video to MP3
base_dir="${2:-./music}"  # Default to current directory if not provided
yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 --output "${base_dir}/%(title)s.%(ext)s" "$1"

# Check if the download was successful
if [ $? -eq 0 ]; then
  echo "Song downloaded and converted to MP3 successfully."
else
  echo "Error downloading or converting the song."
  exit 1
fi
