#!/bin/bash

exe="./lab3.out"
input_folder="./input"
output_folder="./output"
answer_folder="./answer"

if [ -x "$exe" ]; then
  echo "Starting test"
  
  mkdir -p "$output_folder"


  #Test if program exits when not given enough arguments
  $exe > /dev/null

  exit_status=$?

  # if you have your return in main to be something else you can change it here.
  if [ $exit_status -eq 1 ]; then
    echo "Program exited gracefully with no arguments"
  else
    echo "Program doesn't gracefully exit on arguments"
  fi


  #test if program exits gracefully on missing input
  $exe "fake_input" "$output_file" 4 > /dev/null 2>&1

  exit_status=$?

  if [ $exit_status -eq 0 ]; then
    echo "Program exited gracefully with no fake_input"
  else
    echo "Program doesn't gracefully exit on missing input"
  fi

  for input in "$input_folder"/input*.txt; do
    test_num="${input##*input}"
    test_num="${test_num%.*}"
    #echo "running test case $test_num"

    output_file="$output_folder/output$test_num.txt"
    $exe "$input" "$output_file" 3

    answer_file="$answer_folder/answer$test_num.txt"
    if diff -q "$output_file" "$answer_file" > /dev/null; then
      echo "Test case $test_num: Passed"
    else
      echo "Test case $test_num: Failed"
      diff "$output_file" "$answer_file"
      echo ""
    fi
  done
else
  echo "Executable not Found. Please compile your C code first with the makefile"
fi
