#!/bin/bash

#
# Function to traverse files in a directory and sub-directories
#
function processfile() {

    for f in $1/*
        do
        if [ -f $f ]
        then
            # Invoke function to find lines with matched string
            match=$(findstr  $2  $f)
            # Count only the files with matched line/lines 
            if [ $match -gt 0]
            then
                ((numfiles=numfiles+1))
            fi

            ((matchlines=matchlines+match))

        elif [ -d $f ]
        then
            # Recursively search the sub-directory
            processfile $f $2      

        fi
        done

}

#
# Function to find number of lines matching a string in a file
#
function findstr() {

     grep -c "$1" $2

}

# Variable to keep track of number of files searched
numfiles=0
# Variable to keep track of number of matched lines
matchlines=0
# Variable to temporarily store count of matched lines in a file
match=0

if [ $# -ne 2 ]
then 
     printf "Not All Or Excess Parameters Specified for the script"
     exit 1
else
    if [ -d $1 ]
    then 
        for file in $1/*
        do
        if [ -f $file ]
        then
        
            ((numfiles=numfiles+1))

            # Invoke function to find lines with matched string
            match=$(findstr  $2  $file)

            ((matchlines=matchlines+match))

        elif [ -d $file ]
        then
            # Recursively search the sub-directory
            processfile $file $2
             
        fi
        done
    else
        printf "First argument does not represent a directory on the filesystem"
        exit 1
    fi

    printf "The number of files are %d and the number of matching lines are %d" ${numfiles} ${matchlines}
fi