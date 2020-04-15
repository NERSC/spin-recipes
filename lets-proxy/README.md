# Let's Encrypt

This is an example using the Let's Encrypt helper image.  This image will handle obtaining the let's encrypt certificate, install it in an nginx proxy and may everything to a back end service.

## Assumptions

* You have a DNS domain that you can create a CNAME pointing to Spin
* You have a backend service that can handle unencrypted http listening on a port.

## Setup

Make sure you have updated the DNS entry for your domain to point to the SNI container in spin.
For example, `lb-sni.reverse-proxy.prod-cattle.stable.spin.nersc.org.` for the production spin service.

## Usage

Create the volume to hold the letsencrypt state

```bash
rancher volume create --driver rancher-nfs web.mydomain-net
```

Add a stanza to your docker-compose like the following...

```yaml
version: '2'

services:
  web-lets:
    image: registry.spin.nersc.gov/das/letsencrypt:latest
    restart: always
    volumes:
    - web.mydomain-net:/etc/letsencrypt/
    environment:
      LE_DOMAIN: web.mydomain.net
      LE_EMAIL: user@mydomain.net
      PROXY: web-app:80
    cap_add:
    - NET_BIND_SERVICE
    - SETGID
    - SETUID
    cap_drop:
    - ALL

    labels:
      io.rancher.container.pull_image: always
```

The LE_ environment variables should correspond to the domain name that you have registered and your email.
The PROXY should point to another container in your stack that is listening for unencrypted http traffic.  Just
provide the container name and port.

Bring up the stack using `rancher up -u -d`.  Once started, notify the Spin staff to create the mapping.  The mappings
should be for port 80 (http)  and port 443 (SNI) on the lb-sni container.  They should point to the web-lets container.

If everything works correctly, the container should obtain the certificate automatically and start up a listener on https.
This may take a few minutes to happen.  The logs should indicate if things are working correctly.



