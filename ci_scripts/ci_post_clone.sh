#!/bin/sh

set -e

# Exit if TMDB_ACCESS_TOKEN is not set
if [ -z "$TMDB_ACCESS_TOKEN" ]; then
  echo "Error: TMDB_ACCESS_TOKEN environment variable not set"
  exit 1
fi

# Define the output file path
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTPUT_FILE="$SCRIPT_DIR/../Kinova/Secrets.swift"

# Write the Swift file
cat > "$OUTPUT_FILE" <<EOL
// This file is auto-generated. Do not edit.

enum Secrets {
  static let tmdbAccessToken = #"""
    $TMDB_ACCESS_TOKEN
    """#
}
EOL

echo "Secrets.swift generated at $OUTPUT_FILE"
