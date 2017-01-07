#!/bin/bash

function split() {
    nu=0;
    fileNumber=0;
    fileName="f$fileNumber.txt"
    while read line
    do
        echo $nu
        if test $nu -gt $1;then
            nu=0
            fileNumber=`expr $fileNumber + 1`;
            fileName="f$fileNumber.txt";
        fi
        echo $line >> $fileName;
        nu=`expr $nu + 1`;
    done < $2
}

split $1 $2;
