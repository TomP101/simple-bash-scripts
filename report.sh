#!/bin/bash

echo $('date')
echo $USER
ifconfig | grep -w "inet"
echo $('hostname')
uname -v
uptime
df -u


