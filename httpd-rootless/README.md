# httpd-rootless

The `httpd-rootless` container extends the stock Apache httpd image to run as
an arbitrary UID/GID.

Advantages over the stock image include:
  * Allows a regular user to run a httpd container and access host or NFS
    resources such as the NERSC Global Filesystem.
  * Allows us to drop all remaining Linux capabilities through `cap_drop: ALL`,
    which avoids many root-level privileges and improves security. 
  * Avoids the need for [`RUN groupadd ... && useradd ...`][1], which would
    result in every single user building their own custom container instead.

Run this image this using `docker container run`, like:

    docker container run -p 80:8080 --cap-drop=all --user SOMEUID:SOMEGID --group-add www-data ... httpd-rootless

Or, run this image as root by not using the `--user` & `--group_add` flags:

    docker container run -p 80:8080 ... httpd-rootless

Or, run with the Docker Compose equivalent (see the accompanying `docker-compose.yml` file).

Note that `--group-add` is required, and enables the user to write the PID file
to `/usr/local/apache2/logs/`. Docker Compose v2 is required. Docker Compose v3
does not support `--group-add`, nor [does it have an equivalent][2]. 

[1]: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
[2]: https://github.com/docker/compose/issues/3328#issuecomment-296813818
