# This image extends the official httpd image to run as an arbitrary UID/GID.

# See the README.md for usage

FROM httpd:latest

LABEL \
  org.opencontainers.image.authors="Stefan Lasiewski <slasiewski@lbl.gov> <stefanl@nersc.gov>" \
  org.opencontainers.image.description="This image extends the official httpd image to run as an arbitrary UID/GID."

# httpd writes it's PID file to /usr/local/apache2/log. Allow the group
# `www-data` to write to this directory.
RUN chmod g+w /usr/local/apache2/logs

# Run as port 8080 (unprivileged) instead of port 80 (privileged).
# sed borrowed from https://github.com/docker-library/httpd/blob/master/2.4/Dockerfile
RUN sed -i.bak -e 's#^Listen 80*$#Listen 8080#' $HTTPD_PREFIX/conf/httpd.conf
EXPOSE 8080
