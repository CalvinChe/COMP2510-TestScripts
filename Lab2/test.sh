#!/bin/bash

exe="./lab2.out"
input_folder="./input"
output_folder="./output"
answer_folder="./answer"

if [ -x "$exe" ]; then
  echo "Starting test"
  
  mkdir -p "$output_folder"

  for input in "$input_folder"/input*.txt; do
    test_num="${input##*input}"
    test_num="${test_num%.*}"
    #echo "running test case $test_num"

    output_file="$output_folder/output$test_num.txt"
    $exe "$input" > "$output_file"

    answer_file="$answer_folder/answer$test_num.txt"
    if diff -q <(tail -n +2 "$output_file") <(tail -n +2 "$answer_file") > /dev/null; then
      echo "Test case $test_num: Passed"
    else
      echo "Test case $test_num: Failed"
    fi
  done
else
  echo "Executable not Found. Please compile your C code first with the makefile"
fi
