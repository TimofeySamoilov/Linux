#!/bin/bash
position="/log"
#1test:
sudo fallocate -l 100M /mnt$position/file1.txt
sudo fallocate -l 102M /mnt$position/file2.txt
sudo fallocate -l 200M /mnt$position/file3.txt
./TestScript.sh 1 $position 40
if [[ -f /home/bevilion/backup/archive.tar.gz ]]
then
  echo "Test 1 is passed"
else
  echo "Test 1 is failed"
fi

#2test:
sudo fallocate -l 123M /mnt$position/file1.txt
sudo fallocate -l 34M /mnt$position/file2.txt
sudo touch /mnt$position/p.py
sudo touch /mnt$position/p2.py
./TestScript.sh 2 $position 50
if [[ -f /home/bevilion/backup/archive.tar.gz ]]
then
  if [[ -f /mnt$position/p2.py ]]
  then
    echo "Test 2 is passed"
  else
    echo "Test 2 is failed"
  fi
else
  echo "Test 2 is failed"
fi
sudo rm /mnt$position/p2.py

#3test:
sudo fallocate -l 123M /mnt$position/file1.txt
sudo fallocate -l 3M /mnt$position/file2.txt
sudo fallocate -l 2M /mnt$position/file3.txt
sudo fallocate -l 1M /mnt$position/file4.txt
./TestScript.sh 3 $position 70
if [[ -f /mnt$position/file1.txt && -f /mnt$position/file2.txt && -f /mnt$position/file3.txt && -f /mnt$position/file4.txt ]]
then
  echo "Test 3 is passed"
else
  echo "Test 3 is failed"
fi
sudo rm /mnt$position/file1.txt /mnt$position/file2.txt /mnt$position/file3.txt /mnt$position/file4.txt

#4test
sudo fallocate -l 94M /mnt$position/file1.txt
sudo fallocate -l 86M /mnt$position/file2.txt
sudo fallocate -l 102M /mnt$position/file3.txt
sudo fallocate -l 4M /mnt$position/file4.txt
sudo fallocate -l 6M /mnt$position/file5.txt
./TestScript.sh 4 $position 22
if [[ -f /mnt$position/file4.txt && -f /mnt$position/file5.txt ]]
then
  echo "Test 4 is passed"
else
  echo "Test 4 is failed"
fi
sudo rm /mnt$position/file4.txt /mnt$position/file5.txt

#5test
./TestScript.sh 5 "jskjks" 22
if [ $? -eq 0 ]
then
  echo "Test 5 is passed"
else
  echo "Test 5 is failed"
fi
