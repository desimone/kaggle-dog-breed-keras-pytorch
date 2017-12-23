# Network Finetuning Example in Pytorch and Keras

Made as an example for a friend working through the kaggle competion to do [dog breed identifcation](https://www.kaggle.com/c/dog-breed-identification). Thought it would be fun to compare keras and pytorch. Both networks use the same data, and architectures. Unsurprisingly, they both achieve nearly identical results.

About [250](https://www.kaggle.com/c/dog-breed-identification/leaderboard) on the leaderboard, but just taking a glance over there it looks like people pretrained on the Stanford dog dataset and now have "won" by overfitting. Sad!

Included my models for both for those interested. 

Data you will have to get on kaggle.

## Data
Assumes following directory structure.

```bash
.
├── data
│   ├── classify_by_dir.sh
│   ├── labels.csv
│   ├── sample_submission.csv
│   ├── sample_submission.csv.zip
│   ├── test
│   ├── test.zip
│   ├── train
│   ├── train.zip
│   ├── unsorted
│   └── val
├── keras.best.h5
├── keras.ipynb
└── submit.csv
```
Save the following script in your data directory as `classify_by_dir.sh` then run

`unzip train.zip && mv train unsorted && ./classify_by_dir.sh`

```bash
#!/bin/bash
shuf -o labels.csv <labels.csv
unsorted_dir=unsorted
counter=0
# SHUFFLE THE FILE WOOO
while IFS=, read -r image class; do
	# very roughly 25% to val
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
```

License: MIT