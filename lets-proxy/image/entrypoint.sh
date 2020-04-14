#!/bin/bash


if [ ! -e /etc/letsencrypt/live/ ] ; then
   echo "Boot strap LE"

   echo "Starting nginx"
   nginx &

   curl -s -f $LE_DOMAIN > /dev/null
   while [ $? -ne 0 ] ; do
      echo "Not mapped yet" 
      sleep 10
      curl -s -f $LE_DOMAIN > /dev/null
   done
   certbot -d $LE_DOMAIN -m $LE_EMAIL --agree-tos --nginx --no-eff-email

   # Test for SSL
   kill $(cat /var/run/nginx.pid) 
fi

cat ssl.conf | \
   sed "s/backend-app/$PROXY/" | \
   sed "s/mysite.com/$LE_DOMAIN/" > /etc/nginx/conf.d/ssl.conf

# Start renewer
./renew.sh &

# Start nginx
nginx -g "daemon off;"

# This is for debugging purposes.  Set sleep to some value
# to be able to exec in.
[ -z $SLEEP ] || sleep $SLEEP
