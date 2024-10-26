#!/bin/bash

# Function to search YouTube and download audio
search_and_download() {
    local query="$1"
    local base_dir="${2:-./music}"  # Default to current directory if not provided
    local num_results="${2:-1}"

    echo "Searching for: $query"
    
    # Search and download audio using yt-dlp
    yt-dlp --extract-audio --audio-format mp3 \
           --audio-quality 192K \
           --download-archive "${base_dir}/downloaded.txt" \
           -o "${base_dir}/%(title)s.%(ext)s" \
           "ytsearch${num_results}:${query}"
}

# Check if a CSV file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <csv_file>"
    exit 1
fi

# Read the CSV file and process each line
while IFS=',' read -r track artist _; do
    # Concatenate the first three columns to form the search query
    query="${track} ${artist}"
    
    # Call the download function with the query
    search_and_download "$query" 1
done < "$1"
