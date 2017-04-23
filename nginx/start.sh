#!/bin/bash

echo "NGINX_HOST is $NGINX_HOST"
echo "NGINX_DOMAIN is $NGINX_DOMAIN"
echo "NGINX_PORT is $NGINX_PORT"
echo "NGINX_SRC_HOST is $NGINX_SRC_HOST"
echo "NGINX_SRC_PORT is $NGINX_SRC_PORT"
echo "NGINX_AUTH is $NGINX_AUTH"
echo "NGINX_USER is $NGINX_USER"
echo "NGINX_PASS is $NGINX_PASS"

if [ "${NGINX_AUTH}" = "true" ]
  then
    echo NGINX_AUTH is  ${NGINX_AUTH}
    envsubst < /assets/proxy-password.template > /etc/nginx/conf.d/default.conf
    sh -c "echo -n '${NGINX_USER}:' >> /etc/nginx/.htpasswd"
    sh -c "echo ${NGINX_PASS}|openssl passwd -apr1 -stdin >>/etc/nginx/.htpasswd"
else
    echo NGINX_AUTH is  ${NGINX_AUTH}
    envsubst < /assets/proxy.template > /etc/nginx/conf.d/default.conf
fi

nginx -g 'daemon off;'
