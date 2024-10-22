# mtls-with-proxy-poc

PoC setup of simple python HTTP get with SSL certs.
Simple PoC project to verify the flow of "mTLS" authentication through the "corporate" (e.g. forward) proxy.

You simply setup 3 components:
- NGINX with SSL auth
- SQUID as a transparent proxy
- GUNICORN as your mTLS sidecard (it will inject the SSL client cert and key so you'll be able to authenticate against the NGINX server)

**NOTE:** Do not even expect that it will work out of the box!

## Requirements

You should have some reasonable of docker and docker-compose.

## Initial setup

### Generate SSL certs

```
bash generate_tls.sh
```

### Build simple flask app

```
cd gunicorn
docker build . -t simple-flask
```

### Run docker compose

From the **root** of this repo folder do:

```
docker compose up
```

### Test it with curl

```
curl localhost:5000
```

You should get 200 response ... if not something went wrong and you have to debug that
