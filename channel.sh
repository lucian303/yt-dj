#!/bin/bash

# Function to download all videos from a channel and convert to MP3
download_channel_as_mp3() {
    local channel_url="$1"
    local base_dir="${2:-./music}"  # Default to current directory if not provided

    # Ensure the base directory exists
    mkdir -p "$base_dir"

    echo "Downloading all videos from channel: $channel_url"
    echo "Saving MP3 files to: $base_dir"

    # Use yt-dlp to download videos and extract audio as MP3
    yt-dlp --extract-audio --audio-format mp3 \
           --audio-quality 192K \
           -o "${base_dir}/%(title)s.%(ext)s" \
           "$channel_url"
}

# Check if the channel URL is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <channel_url> [output_directory]"
    exit 1
fi

# Call the function with the provided arguments
download_channel_as_mp3 "$1" "$2"
