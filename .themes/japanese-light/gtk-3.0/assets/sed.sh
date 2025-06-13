#!/bin/sh
sed -i \
         -e 's/#f3f3f3/rgb(0%,0%,0%)/g' \
         -e 's/#3c3c3c/rgb(100%,100%,100%)/g' \
    -e 's/#f3f3f3/rgb(50%,0%,0%)/g' \
     -e 's/#B1ABB2/rgb(0%,50%,0%)/g' \
     -e 's/#f3f3f3/rgb(50%,0%,50%)/g' \
     -e 's/#3c3c3c/rgb(0%,0%,50%)/g' \
	"$@"
