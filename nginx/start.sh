#!/bin/bash

if [ "${NGINX_AUTH}" -eq "true" ]
  then
    envsubst < /assets/proxy-password.conf > /etc/nginx/conf.d/default.conf
    sh -c "echo -n '${NGINX_USER}:' >> /etc/nginx/.htpasswd"
    sh -c "echo ${NGINX_PASS}|openssl passwd -apr1 -stdin >>/etc/nginx/.htpasswd"
else
    envsubst < /assets/proxy.conf > /etc/nginx/conf.d/default.conf
fi

nginx -g 'daemon off;'
