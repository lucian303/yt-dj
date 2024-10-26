#!/bin/bash

# Path to the cookies file
COOKIES_FILE="./cookies.txt"  # Replace with the full path to your cookies.txt

# Check if cookies file exists
if [ ! -f "$COOKIES_FILE" ]; then
  echo "Error: Cookies file not found at $COOKIES_FILE." >&2
  exit 1
fi

# Check if a URL is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <youtube_playlist_url>"
  exit 1
fi

# Download and convert playlist videos to MP3 using cookies for authentication
base_dir="${2:-./music}"  # Default to current directory if not provided
yt-dlp --cookies "$COOKIES_FILE" --extract-audio --audio-format mp3 --audio-quality 0 --output "$base_dir/%(title)s.%(ext)s" "$1"

# Check if download was successful
if [ $? -eq 0 ]; then
  echo "Playlist downloaded and converted to MP3 successfully."
else
  echo "Error downloading or converting thel playlist."
  exit 1
fi
