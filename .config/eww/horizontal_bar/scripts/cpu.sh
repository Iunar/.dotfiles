#!/bin/bash

echo $(cat /proc/stat | grep -P '^cpu\d{,2}[\s\d]*' | sed G)
