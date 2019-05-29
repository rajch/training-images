#!/bin/bash

if [ "$1" == "" ] ; then
    echo "Usage: $0 NEWHOSTNAME"
else
    echo "Setting hostname..."
    OLDNAME=$(hostname)
    hostnamectl set-hostname $1
    if [ $? -eq 0 ] ; then
        sed --in-place=".bak" "s/${OLDNAME}/$1/g" /etc/hosts
        echo "Hostname changed to $1. Please reboot."
    else
        echo "Hostname not set." >2
    fi
fi
