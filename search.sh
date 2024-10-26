#!/bin/bash

# Function to search YouTube and download audio
search_and_download() {
    query="$1"
    num_results="${2:-1}"
    local base_dir="${2:-./music}"  # Default to current directory if not provided

    # Use yt-dlp to search for videos and extract the video URLs
    echo "Searching for: $query"
    
    # yt-dlp's ytsearch can directly download the best audio format
    yt-dlp --extract-audio --audio-format mp3 \
           --audio-quality 192K \
           -o "${base_dir}/%(title)s.%(ext)s" \
           "ytsearch${num_results}:${query}"
}

# Check if the search query is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <search query> [number of results]"
    exit 1
fi

# Run the search and download function with provided input
search_and_download "$1" "$2"
