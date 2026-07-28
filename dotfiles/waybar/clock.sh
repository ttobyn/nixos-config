#!/bin/bash

time=$(date +'%I:%M %p')
date=$(date +'%d %A %b')

printf "%s\n%s\n" "$time" "$date"
