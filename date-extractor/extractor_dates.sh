#!/bin/bash

# 1. Set directory paths
NOTES_DIR="./notes"
OUTPUT_FILE="dates_report.csv"

# 2. Write the header of the report
echo "Filename,Extracted Date,Cleaned Line" > "$OUTPUT_FILE"

# 3. Loop through each note file
for file in "$NOTES_DIR"/*.txt; do
    while IFS= read -r line; do
# 4. clean the line from punctuation using sed
clean_line=$(echo "$line" | sed 's/[.,!?]//g')
# 5. this line extracts the dates using grep and xargs and stores them in the variable matches
matches=$(echo "$clean_line" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}|[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}|[0-9]{1,2} [A-Z][a-z]+ [0-9]{4}')
# 6. print the final results by using awk
echo "$matches" | awk -v file="$(basename "$file")" -v line="$clean_line" 'NF { print file "," $0 "," line }' >> "$OUTPUT_FILE"
done < "$file"
done
echo " Dates successfully extracted, Check the file: $OUTPUT_FILE "



