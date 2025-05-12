#!/bin/bash

# echo $(uptime | grep -Po '(?<=(up\s))\d{,2}(?=:)')
# echo $(uptime | grep -Po '(?<=(up\s))\d{,2}:\d{,2}(?=,)')
echo $(uptime | grep -Po '(?<=(up\s))\d{,2}:\d{,2}(?=,)')
