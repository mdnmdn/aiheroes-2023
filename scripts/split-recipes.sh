#!/bin/bash

script_path=$(dirname "$0")

#input_file=$1
#output_directory=$2

output_directory="$script_path/../data/recipes"

#rm -rf $output_directory
#mkdir -p $output_directory

function split_recipes() {
    input_file="$script_path/../assets/$1"

    awk -v output_directory="$output_directory" '
    BEGIN { RS = "\n## "; FS = "\n"; ORS = "" }
    NR > 1 {
        title = $1;
        gsub(/ /, "-", $1);
        gsub(/[^a-zA-Z0-9-]/, "", $1);
        filename = output_directory "/" tolower($1) ".md";
        print "## " title "\n\n" > filename;
        for (i=2; i<=NF; i++) {
            print $i "\n" > filename;
        }
    }' $input_file
}


split_recipes "recipes-1.md"
split_recipes "recipes-2-colored.md"
split_recipes "recipes-3-meat.md"
split_recipes "recipes-4-dessert.md"

echo recipes: $(ls $output_directory | wc -l)



