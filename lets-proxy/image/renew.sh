#!/bin/sh

while true ; do
   echo Check renewal
   certbot renew
   sleep 3600
done
