# This image extends the official httpd image to run as an arbitrary UID/GID.

# See the README.md for usage

FROM httpd:latest

LABEL \
  org.opencontainers.image.authors="Stefan Lasiewski <slasiewski@lbl.gov>" \
  org.opencontainers.image.description="This image extends the official httpd image to run as an arbitrary UID/GID."

# httpd writes it's PID file to /usr/local/apache2/log. Allow the group
# `www-data` to write to this directory.
RUN chmod g+w /usr/local/apache2/logs

# Run as port 8080 (unprivileged) instead of port 80 (privileged), which will
# allow non-root users to use this image, and improve security by allowing us
# to drop the 'cap_net_bind_service' capability.
#
# Activate mod_remoteip to obtain the client IP address from headers passed
# by the Spin reverse proxy, adjust log formats accordingly, and add basic
# directives.
#
# sed borrowed from https://github.com/docker-library/httpd/blob/master/2.4/Dockerfile
ADD httpd.conf-append /tmp/
RUN sed -i.bak \
  -e 's/^Listen 80*$/Listen 8080/' \
  -e 's/^#LoadModule remoteip_module/LoadModule remoteip_module/' \
  -e 's/LogFormat "%h/LogFormat "%a/' \
  $HTTPD_PREFIX/conf/httpd.conf && \
  cat /tmp/httpd.conf-append >> $HTTPD_PREFIX/conf/httpd.conf && \
  rm -f /tmp/httpd.conf-append
EXPOSE 8080
