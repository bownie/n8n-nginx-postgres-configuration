server {
	listen 80;
	listen [::]:80;

	server_name n8n.yourdomain.com;

	return 301 https://n8n.yourdomain.com$request_uri;
}

server {
	listen 443;
	listen [::]:443;

	# Paths to certificate files.
	ssl_certificate /etc/letsencrypt/live/n8n.yourdomain.com/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/n8n.yourdomain.com/privkey.pem;

        # Default server block rules
        #include global/server/defaults.conf;

        # Fastcgi cache rules
        include global/server/fastcgi-cache.conf;

        # SSL rules
        include global/server/ssl.conf;

	server_name n8n.yourdomain.com;

	location / {
		proxy_pass http://localhost:5678;
		proxy_http_version 1.1;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection "upgrade";
		proxy_read_timeout 86400;
	}

}
