 server {
     listen 80;
     listen [::]:80; # IPV6
     server_name [SERVER_ADDRESS];

     location /static/ {
         alias /var/snap/fiduswriter/current/static-collected/;
         expires max;
     }

     location / {
         proxy_pass http://127.0.0.1:4386;
         proxy_set_header X-Real-IP $remote_addr;
         proxy_set_header Host $host;
         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
         proxy_set_header X-Forwarded-Proto $scheme;

          # WebSocket support (nginx 1.4)
         proxy_http_version 1.1;
         proxy_set_header Upgrade $http_upgrade;
         proxy_set_header Connection "upgrade";
         client_max_body_size 8M;
     }

}
