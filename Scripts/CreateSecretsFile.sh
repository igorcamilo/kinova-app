#!/bin/sh

set -e

# Exit if TMDB_ACCESS_TOKEN is not set
if [ -z "$TMDB_ACCESS_TOKEN" ]; then
  echo "Error: TMDB_ACCESS_TOKEN environment variable not set"
  exit 1
fi

# Define the output file path
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTPUT_FILE="$SCRIPT_DIR/../Kinova/KinovaSecrets.swift"

# Write the Swift file
cat > "$OUTPUT_FILE" <<EOL
// This file is auto-generated. Do not edit.

enum KinovaSecrets {
  static let tmdbAccessToken = "$TMDB_ACCESS_TOKEN"
}
EOL

echo "KinovaSecrets.swift generated at $OUTPUT_FILE"
