#!/bin/bash

#1st Requirement is to create a shell script


: '
Step 1: Take input as either 0 or 1
This part prompts the user to enter a value (either 0 or 1), which is read into the variable "input".
'
echo "Enter 1 to create folder and file, 0 to delete folder:"
read input

: '
Step 2: Conditional check based on input value (0 or 1)
This conditional checks whether the input is 1 or 0, and then performs the respective action.
'

if [ "$input" -eq 1 ]; then                                    #This condition is to create folder and directory
  mkdir -p /home/roopa/test_directory
  touch /home/roopa/test_directory/testfile.txt
  echo "Folder and file created successfully."

elif [ "$input" -eq 0 ]; then                             #This condition is to delete the folder and file
  rm -rf /home/roopa/test_directory 
  echo "Folder deleted successfully."

else
  echo "Invalid input. Please enter 0 or 1."
fi

