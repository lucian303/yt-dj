#!/bin/bash

# Set the path to yt-dlp or youtube-dl
YOUTUBE_DL="yt-dlp"  # Adjust the path if necessary

# Path to ffmpeg (if not in PATH)
FFMPEG="ffmpeg"  # Adjust the path if necessary

# Output directory for MP3 files
OUTPUT_DIR="./music"  # Set your desired output directory



# Check if yt-dlp is installed
if ! [ -x "$(command -v $YOUTUBE_DL)" ]; then
  echo "Error: yt-dlp or youtube-dl is not installed." >&2
  exit 1
fi

# Check if ffmpeg is installed
if ! [ -x "$(command -v $FFMPEG)" ]; then
  echo "Error: ffmpeg is not installed." >&2
  exit 1
fi

# Check if a URL is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <youtube_url>"
  exit 1
fi

# YouTube video URL (taken as the first parameter)
VIDEO_URL="$1"

# Create the output directory if it doesn't exist
if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir -p "$OUTPUT_DIR"
fi

# Download and convert video to MP3
$YOUTUBE_DL --extract-audio --audio-format mp3 --audio-quality 0 --output "$OUTPUT_DIR/%(title)s.%(ext)s" "$VIDEO_URL"

# Check if the download was successful
if [ $? -eq 0 ]; then
  echo "Song downloaded and converted to MP3 successfully."
else
  echo "Error downloading or converting the song."
  exit 1
fi
