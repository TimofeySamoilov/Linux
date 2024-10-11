#!/bin/bash
#1test:
sudo fallocate -l 100M /mnt/papka/file1.txt
sudo fallocate -l 102M /mnt/papka/file2.txt
sudo fallocate -l 200M /mnt/papka/file3.txt
./TestScript.sh 1 /papka 40
if [[ -f /home/bevilion/backup/archive.tar.gz ]]
then
  echo "Test 1 is passed"
else
  echo "Test 1 is failed"
fi
#2test:
sudo fallocate -l 123M /mnt/papka/file1.txt
sudo fallocate -l 34M /mnt/papka/file2.txt
sudo touch /mnt/papka/p.py
sudo touch /mnt/papka/p2.py
./TestScript.sh 2 /papka 50
if [[ -f /home/bevilion/backup/archive.tar.gz ]]
then
  if [[ -f /mnt/papka/p2.py ]]
  then
    echo "Test 2 is passed"
  else
    echo "Test 2 is failed"
  fi
else
  echo "Test 2 is failed"
fi
sudo rm /mnt/papka/p2.py
#3test:
sudo fallocate -l 123M /mnt/papka/file1.txt
sudo fallocate -l 3M /mnt/papka/file2.txt
sudo fallocate -l 2M /mnt/papka/file3.txt
sudo fallocate -l 1M /mnt/papka/file4.txt
./TestScript.sh 3 /papka 70
if [[ -f /mnt/papka/file1.txt && -f /mnt/papka/file2.txt && -f /mnt/papka/file3.txt && -f /mnt/papka/file4.txt ]]
then
  echo "Test 3 is passed"
else
  echo "Test 3 is failed"
fi
sudo rm /mnt/papka/file1.txt /mnt/papka/file2.txt /mnt/papka/file3.txt /mnt/papka/file4.txt
#4test
sudo fallocate -l 94M /mnt/papka/file1.txt
sudo fallocate -l 86M /mnt/papka/file2.txt
sudo fallocate -l 102M /mnt/papka/file3.txt
sudo fallocate -l 4M /mnt/papka/file4.txt
sudo fallocate -l 6M /mnt/papka/file5.txt
./TestScript.sh 4 /papka 42
if [[ -f /mnt/papka/file4.txt && -f /mnt/papka/file5.txt ]]
then
  echo "Test 4 is passed"
else
  echo "Test 4 is failed"
fi
sudo rm /mnt/papka/file4.txt /mnt/papka/file5.txt
