#!/bin/sh

if [ "${NGINX_AUTH}" = "true" ]
  then
    envsubst '$$NGINX_HOST $$NGINX_DOMAIN $$NGINX_PORT $$NGINX_SRC_HOST $$NGINX_SRC_PORT $$NGINX_AUTH $$NGINX_USER $$NGINX_PASS' \
      < /assets/${NGINX_TEMPLATE}-password.template \
      > /etc/nginx/conf.d/default.conf
    sh -c "echo -n '${NGINX_USER}:' >> /etc/nginx/.htpasswd"
    sh -c "echo ${NGINX_PASS}|openssl passwd -apr1 -stdin >>/etc/nginx/.htpasswd"
else
    envsubst '$$NGINX_HOST $$NGINX_DOMAIN $$NGINX_PORT $$NGINX_SRC_HOST $$NGINX_SRC_PORT $$NGINX_AUTH $$NGINX_USER $$NGINX_PASS' \
      < /assets/${NGINX_TEMPLATE}.template \
      > /etc/nginx/conf.d/default.conf
fi

if [ "${NGINX_DEBUG}" = "true" ]
  then
    echo "NGINX_HOST is $NGINX_HOST"
    echo "NGINX_DOMAIN is $NGINX_DOMAIN"
    echo "NGINX_PORT is $NGINX_PORT"
    echo "NGINX_SRC_HOST is $NGINX_SRC_HOST"
    echo "NGINX_SRC_PORT is $NGINX_SRC_PORT"
    echo "NGINX_AUTH is $NGINX_AUTH"
    echo "NGINX_USER is $NGINX_USER"
    echo "NGINX_PASS is $NGINX_PASS"
    echo '<<CONFIG>>'
    cat /etc/nginx/conf.d/default.conf
    echo '<<END_CONFIG>>'
else
    echo "Starting $NGINX_HOST"
fi

nginx -g 'daemon off;'
