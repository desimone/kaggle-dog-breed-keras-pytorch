#!/bin/bash
shuf -o labels.csv <labels.csv
unsorted_dir=unsorted
counter=0
# SHUFFLE THE FILE WOOO
while IFS=, read -r image class; do
	# very roughly 20% move to val
	if (($counter == 4)); then
		sorted_dir=val
		mkdir -p $sorted_dir/$class
		mv $unsorted_dir/$image.jpg $sorted_dir/$class/$image.jpg
		counter=0
	else
		sorted_dir=train
		mkdir -p $sorted_dir/$class
		mv $unsorted_dir/$image.jpg $sorted_dir/$class/$image.jpg
	fi
	((counter++))

done <labels.csv
