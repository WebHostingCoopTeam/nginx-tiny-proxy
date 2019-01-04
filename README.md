#!/bin/bash


If  you supply NGINX_AUTH="true"
then use these environment vars:

 '$$NGINX_HOST $$NGINX_DOMAIN $$NGINX_PORT $$NGINX_SRC_HOST $$NGINX_SRC_PORT $$NGINX_AUTH $$NGINX_USER $$NGINX_PASS'


To replace the vars in [this file](https://github.com/WebHostingCoopTeam/nginx-tiny-proxy/blob/master/nginx/full-password.template)
otherwise don't use auth and instead use [this file](https://github.com/WebHostingCoopTeam/nginx-tiny-proxy/blob/master/nginx/full.template)

for example:

```
upstream upstream_src {
  ip_hash;
  server ${NGINX_SRC_HOST}:${NGINX_SRC_PORT};
}

server {
  listen 80;
  server_name ${NGINX_HOST}.${NGINX_DOMAIN};
  root /usr/share/nginx/html;

  location / {
    auth_basic "Restricted";
    auth_basic_user_file /etc/nginx/.htpasswd;
    proxy_pass http://upstream_src;
    proxy_http_version 1.1;
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_cache_bypass $http_upgrade;
  }
}
```
