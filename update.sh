#!/bin/bash

count=`date +"%Y.%m.%d-%H:%M:%S"`

git add .; git commit -m "update#"$count -a; git push -v
