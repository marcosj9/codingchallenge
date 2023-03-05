#!/bin/bash

# Create the CSV file and headers - define the filename that will generate
echo "image1,image2,similar,elapsed" > output.csv

# Read the CSV file containing image paths
while IFS=',' read -r img1 img2; do

    # Get START time
    start_time="$(date +%s.%N)"
    
    # Compare the visual appearance of the pair of images provided by the CSV file , normalizing the size of both to get a more accurate result
    size=$(identify -format "%wx%h" $img2)
    diff=$(compare -metric RMSE -quiet $img1 <(convert $img1 -resize "$size^" -gravity center -extent "$size" -) /dev/null 2>&1 | awk '{print substr($2, 2, length($2) - 2)}')

    # Get END time
    end_time="$(date +%s.%N)"

    # Adds a "0" in front, if time is less than 1 second - bash do not allow decimals
    elapsed_time=$(echo "$end_time - $start_time" | bc)
    if (( $(echo "$elapsed_time < 1" | bc -l) )); then
        elapsed_time="0$elapsed_time"
    fi
    
    # Execution time only two decimals
    elapsed_time=$(printf "%.2f" "$elapsed_time")

    # Append the results to the CSV file
    echo "$img1,$img2,$diff,$elapsed_time" >> output.csv
    
# END of script - define the CSV file that will be read containing the pairs of images  
done < images.csv