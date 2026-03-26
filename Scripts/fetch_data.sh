#!/bin/bash

# ==============================
# CTA Ridership Pipeline - Fetch Script
# Downloads Ridership CSV in 1000-row chunks (up to 50,000 rows)
# ==============================

DATA_DIR="$HOME/Desktop/Dani/CTA Project/Data"
mkdir -p "$DATA_DIR"

# Output file
OUTPUT="$DATA_DIR/ridership.csv"
FIRST_RUN=true

# Start offset
OFFSET=0
LIMIT=1000
MAX_ROWS=50000

echo "Downloading CTA Ridership CSV in 1,000-row increments (up to $MAX_ROWS rows)..."

while [ "$OFFSET" -lt "$MAX_ROWS" ]; do
    TEMP_FILE="$DATA_DIR/ridership_page.csv"

    # Download page
    curl -s "https://data.cityofchicago.org/resource/t2rn-p8d7.csv?\$limit=$LIMIT&\$offset=$OFFSET" \
         -o "$TEMP_FILE"

    # Stop if no data returned
    LINE_COUNT=$(wc -l < "$TEMP_FILE")
    if [ "$LINE_COUNT" -le 1 ]; then
        break
    fi

    if [ "$FIRST_RUN" = true ]; then
        cat "$TEMP_FILE" > "$OUTPUT"  # keep header
        FIRST_RUN=false
    else
        tail -n +2 "$TEMP_FILE" >> "$OUTPUT"  # skip header
    fi

    echo "Downloaded rows $((OFFSET+1)) to $((OFFSET+LINE_COUNT-1))"

    # Increment offset
    OFFSET=$((OFFSET + LIMIT))
done
# remove temp file
rm "$TEMP_FILE"

# ==============================
# Download CTA L Stops Data (all rows)
# ==============================
echo "Downloading CTA L Stops CSV..."
curl -s -o "$DATA_DIR/l_stops.csv" "https://data.cityofchicago.org/resource/8pix-ypme.csv"

echo "All files downloaded successfully to $DATA_DIR!"