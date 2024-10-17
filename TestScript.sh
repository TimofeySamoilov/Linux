#!/bin/bash
echo "Test $1 started"
full_path="/mnt$2"
if [[ -z $2 ]]
then
  echo "Ypu didn't write anything"
  exit 1
fi
if [[ -d $full_path ]]
then
  echo "Test $1 directory successfully opened"
  usage=$(df -h --output=pcent $full_path | tail -1 | sed 's/%//g')
  percentage=$3
  if [[ $usage>$percentage ]]
  then
    if [[ ! -d "/home/bevilion/backup" ]]
    then
      mkdir "backup"
    fi
    cd $full_path
    old_files_count=3
    files=$(find $full_path -type f -printf '%T@ %p\n' | sort -n | head -n $old_files_count | cut -d' ' -f2- | xargs -I {} basename {})
    sudo tar -czf /home/bevilion/backup/archive.tar.gz --absolute-names --warning=no-file-changed $files
    sudo rm $files
    if [ $? -eq 0 ]
    then
      echo "Test $1 successfully archive and remove data to /backup"
    else
      echo "Test $1 archivation error"
    fi
  else
    echo "Test $1 no need archivation"
  fi
else
  echo "Test $1: there is no such directory"
fi
