#!/usr/bin/with-contenv bash


echo "<------------------------------------------------->"
echo
echo "<------------------------------------------------->"
echo "cronjob running on "$(date)
if openssl x509 -checkend 86400 -noout -in /config/nginx/keys/fullchain.pem
then
  echo ">> Certificate is good for another day!"
else
  echo ">> Certificate has expired or will do so within 24 hours!"
  rm /config/nginx/keys/privkey.pem
  rm /config/nginx/keys/fullchain.pem
  /app/cert-create.sh
  nginx -c /config/nginx/nginx.conf -s reload
fi