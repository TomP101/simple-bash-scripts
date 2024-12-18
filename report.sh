#!/bin/bash

echo $('date')
echo $USER
ip addr | grep -w "inet"
echo $('hostname')
uname -v
uptime
df -h
free -ht
grep 'cpu cores' /proc/cpuinfo | uniq
cat /proc/cpuinfo | grep MHz
