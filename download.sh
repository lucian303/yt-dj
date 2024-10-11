#!/bin/bash

# Set the path to yt-dlp or youtube-dl
YOUTUBE_DL="yt-dlp"  # Adjust the path if necessary

# Path to ffmpeg (if not in PATH)
FFMPEG="ffmpeg"  # Adjust the path if necessary

# YouTube Playlist URL
PLAYLIST_URL="https://www.youtube.com/playlist?list=PLN-4sMgMCpaXDLwZLharzXlhRhiuRF38F"  # Replace with your playlist URL

# Output directory for MP3 files
OUTPUT_DIR="/home/lucian303/Desktop/yt-dl/music"  # Set your desired output directory

# Path to the cookies file
COOKIES_FILE="./cookies.txt"  # Replace with the full path to your cookies.txt



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

# Check if cookies file exists
if [ ! -f "$COOKIES_FILE" ]; then
  echo "Error: Cookies file not found at $COOKIES_FILE." >&2
  exit 1
fi

# Create the output directory if it doesn't exist
if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir -p "$OUTPUT_DIR"
fi

# Download and convert playlist videos to MP3 using cookies for authentication
$YOUTUBE_DL --cookies "$COOKIES_FILE" --extract-audio --audio-format mp3 --audio-quality 0 --output "$OUTPUT_DIR/%(title)s.%(ext)s" "$PLAYLIST_URL"

# Check if download was successful
if [ $? -eq 0 ]; then
  echo "Private playlist downloaded and converted to MP3 successfully."
else
  echo "Error downloading or converting the private playlist."
  exit 1
fi
