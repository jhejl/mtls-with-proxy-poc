# mtls-with-proxy-poc

PoC setup of simple python HTTP server that does simple HTTP request against another URL using SSL certs to authenticate itself (e.g. mTLS), but it does that through the SQUID proxy to simulate the most corporate setup one normally doesn't have to deal with, but sometimes he does.

You simply setup 3 components:
- NGINX server with SSL auth required (it just return 200 ok to all requests)
- SQUID as a transparent HTTP(s) proxy
- GUNICORN as your mTLS sidecar (it will inject the SSL client cert and key so you'll be able to authenticate against the NGINX server)
  - the reason why this is described as a sidecar is just because the purpose of it was to use it as a sidecar in a POD of different services

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
