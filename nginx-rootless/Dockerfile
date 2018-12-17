# This image extends the official nginx image to
# run as an arbitrary UID/GID.

# See the README.md for usage

FROM nginx:latest

LABEL \
  org.opencontainers.image.authors="Stefan Lasiewski <slasiewski@lbl.gov>" \
  org.opencontainers.image.description="This image extends the official nginx image to run as an arbitrary UID/GID."

# Make /var/cache/nginx/ writable by non-root users
RUN chgrp nginx /var/cache/nginx/
RUN chmod g+w /var/cache/nginx/

# Modify provided configuration files to help ensure upstream changes are not lost
#
# sed borrowed from https://github.com/docker-library/httpd/blob/master/2.4/Dockerfile
#
# Run as port 8080 (unprivileged) instead of port 80 (privileged), which will
# allow non-root users to use this image, and improve security by allowing us
# to drop the 'cap_net_bind_service' capability.
#
# Configure http_realip_module to obtain the client IP address from headers passed
# by the Spin reverse proxy.
RUN sed -i.bak \
  -e 's/^    listen       80;/    listen     8080;/' \
  -e '/^}/ i real_ip_header    X-Forwarded-For;' \
  -e '/^}/ i set_real_ip_from  10.42.0.0/16;' \
  /etc/nginx/conf.d/default.conf

# Write the PID file to a location where regular users have write access. Not Standards compliant.
RUN sed -i.bak \
  -e 's#^pid        /var/run/nginx.pid;#pid        /var/tmp/nginx.pid;#' \
  /etc/nginx/nginx.conf

EXPOSE 8080
