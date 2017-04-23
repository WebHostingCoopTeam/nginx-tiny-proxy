#!/bin/bash

if [ "${NGINX_AUTH}" -eq "true" ]
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
