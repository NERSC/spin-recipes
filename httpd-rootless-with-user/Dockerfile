# This image extends the official httpd image to
# run as an alternate user. The group is optional.

# See the README.md for usage

FROM httpd:latest

LABEL \
  org.opencontainers.image.authors="Stefan Lasiewski <slasiewski@lbl.gov>" \
  org.opencontainers.image.description="This image extends the official httpd image to run as an alternate user."

# Add an account. There are two choices:

# 1. Add a user account, along with the user's primary group, both of which
# can access files outside the container;  and add 'www-data' as a secondary group
# to allow access to resources inside the container.
#ENV USERNAME=stefanl
#ENV UID=46311
#ENV GROUP=isguser
#ENV GID=75137
#RUN groupadd $GROUP --gid $GID
#RUN useradd --no-log-init $USERNAME --uid $UID --gid $GROUP --groups www-data

# 2. Or, simply add a user account which can access files external to the
# container, and add the account to group 'www-data' to allow access to resources
# inside the container.
ENV USERNAME=stefanl
ENV UID=46311
RUN useradd --no-log-init $USERNAME --uid $UID --groups www-data


# httpd writes it's PID file to /usr/local/apache2/log. Allow the group
# `www-data` to write to this directory.
RUN chmod g+w /usr/local/apache2/logs

# Run as port 8080 (unprivileged) instead of port 80 (privileged), which will
# allow non-root users to use this image, and improve security by allowing us
# to drop the 'cap_net_bind_service' capability.
RUN sed -i.bak -e 's#^Listen 80*$#Listen 8080#' $HTTPD_PREFIX/conf/httpd.conf
EXPOSE 8080
