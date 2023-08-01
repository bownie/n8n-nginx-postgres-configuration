# n8n nginx reverse proxy configuration

Want to set up n8n to run in docker (compose) on your website host?
Running an nginx reverse proxy?

Initially I followed the steps as follows:

https://docs.n8n.io/hosting/installation/server-setups/docker-compose/

This got me so far but a few steps were missing re: nginx config and websockets specifically.

Important steps:

* create your DNS record to point to your n8n.yourdomain.com host
* I added the nginx.yourdomain.com snippet to an existing nginx site configuration (note the SSL cert needs to be generated for your new subsite with your ususal certbot workflow)
* Configure the env file as required and copy it to .env
* docker compose up -d to get n8n running in Postgres

# Troubleshooting

If you're not sure if DNS is correct or if you're even hitting the nginx server at all then (of course) look at the logs. You can always comment out the 'location' block in the nginx config and this will return a default nginx page if you're hitting it.

Some of the docs for n8n nginx config are wrong:

https://community.n8n.io/t/nginx-configuration/111

The location block will work but you'll get websocket connection issues. The snippet in this repo will help. Also see here:

https://stackoverflow.com/questions/53745789/how-to-configure-nginx-to-proxy-ws-websocket-protocol
