#!/bin/bash

#input_file=$1
#output_directory=$2

script_path=$(dirname "$0")

input_file="$script_path/../assets/recipes-1.md"
output_directory="$script_path/../data/recipes"

rm -rf $output_directory
mkdir -p $output_directory

awk -v output_directory="$output_directory" '
BEGIN { RS = "\n## "; FS = "\n"; ORS = "" }
NR > 1 {
    gsub(/ /, "-", $1);
    gsub(/[^a-zA-Z0-9-]/, "", $1);
    filename = output_directory "/" tolower($1) ".md";
    print "## " > filename;
    for (i=1; i<=NF; i++) {
        print $i "\n" > filename;
    }
}' $input_file