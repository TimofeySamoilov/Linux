#!/bin/bash

echo -n "Please, give a folder Path:"
read folder_path

full_path="/mnt$folder_path"
if [[ -d $full_path ]]
then
  echo "This directory was successfully found!"
  usage=$(df -h --output=pcent ${full_path} | tail -1 | sed 's/%//g')
  echo -n "Please write a % of usage when it need to archive:"
  read percentage
  if [[ $usage>$percentage ]]
  then
    if [[ ! -d "/home/bevilion/backup" ]]
    then
      mkdir "backup"
    fi
    cd $full_path
    old_files_count=3
    files=$(find ${full_path} -type f -printf '%T@ %p\n' | sort -n | head -n ${old_files_count} | cut -d' ' -f2- | xargs -I {} basename {})
    sudo tar -czf /home/bevilion/backup/archive.tar.gz --absolute-names --warning=no-file-changed ${files}
    sudo rm ${files}
    #2point:
    #sudo tar -czf papka.tar.gz . --warning=no-file-changed
    #sudo mv papka.tar.gz /home/bevilion/backup
    if [ $? -eq 0 ]
    then
      echo "your data was successfully archived and removed!"
    else
      echo "archivation error"
    fi
  else
    echo "no need to archive"
  fi
else
  echo "There is no such directory"
fi

