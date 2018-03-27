#!/usr/bin/with-contenv bash


echo "<------------------------------------------------->"
echo
echo "<------------------------------------------------->"

if [ ! -f "/config/nginx/keys/dhparams.pem" ]; then
  echo ">> Creating DH parameters for additional security. This may take a very long time. There will be another message once this process is completed"
  mkdir -p /config/nginx/keys
  openssl dhparam -out /config/nginx/keys/dhparams.pem "$DH_SIZE"
  echo ">> DH parameters successfully created - $DH_SIZE bits"
else
  echo ">> dhparams.pem file already exists. Not recreating."	
fi

if [ ! -e "/config/nginx/keys/privkey.pem" ] || [ ! -e "/config/nginx/keys/fullchain.pem" ]
then
  echo ">> Generating self signed cert"
  openssl req -x509 -newkey rsa:4086 \
  -subj "/C=XX/ST=XXXX/L=XXXX/O=XXXX/CN=localhost" \
  -keyout "/config/nginx/keys/privkey.pem" \
  -out "/config/nginx/keys/fullchain.pem" \
  -days 3650 -nodes -sha256
else
  echo ">> Cert and private key exists. Not recreating."
fi