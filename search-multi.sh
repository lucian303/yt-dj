#!/bin/bash

# Function to search YouTube and download audio
search_and_download() {
    local query="$1"
    local num_results="${2:-1}"

    echo "Searching for: $query"
    
    # Use yt-dlp to search and download the best audio format
    yt-dlp --extract-audio --audio-format mp3 \
           --audio-quality 192K \
           -o "music/%(title)s.%(ext)s" \
           "ytsearch${num_results}:${query}"
}

# Array of search queries
titles=(
)

# Loop over the array and download each query's audio
for title in "${titles[@]}"; do
    search_and_download "$title" 1
done
