#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#101013/g' \
         -e 's/rgb(100%,100%,100%)/#c3c3c4/g' \
    -e 's/rgb(50%,0%,0%)/#101013/g' \
     -e 's/rgb(0%,50%,0%)/#B1ABB2/g' \
 -e 's/rgb(0%,50.196078%,0%)/#B1ABB2/g' \
     -e 's/rgb(50%,0%,50%)/#101013/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#101013/g' \
     -e 's/rgb(0%,0%,50%)/#c3c3c4/g' \
	"$@"
