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

# Use 'sed' with # as the separator to modify configuration files
# sed borrowed from https://github.com/docker-library/httpd/blob/master/2.4/Dockerfile

# Run as port 8080 (unprivileged) instead of port 80 (privileged), which will
# allow non-root users to use this image, and improve security by allowing us
# to drop the 'cap_net_bind_service' capability.
RUN sed -i.bak -e 's#^    listen       80;#    listen     8080;#' /etc/nginx/conf.d/default.conf
EXPOSE 8080

# Write the PID file to a location where regular users have write access. Not Standards compliant.
RUN sed -i.bak -e 's#^pid        /var/run/nginx.pid;#pid        /var/tmp/nginx.pid;#' /etc/nginx/nginx.conf
