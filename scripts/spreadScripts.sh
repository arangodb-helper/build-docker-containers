#!/bin/bash

thisScript=`basename $0`
files=""
for targetDir in `find ../distros -type d  |grep scripts`; do 
    for file in *; do
        if test "$file" != "$thisScript"; then
            cp $file $targetDir
            git add $targetDir/$file
            files="$files $targetDir/$file"
        fi
    done
done
    
git commit $files -m "next chunk of scripts"
