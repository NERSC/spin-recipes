# Run httpd as rootless, but specify your own username & group

The `httpd-rootless-with-user` image extends the stock Apache httpd image to
run as an actual user account.

To use this image first add a user account, and an optional group, to the image.
Be sure that `www-data` is added as a supplementary group.

Run this image this using `docker container run`, like:

    docker container run -p 80:8080 --cap-drop=all --user YourUsername:YourGroup --group-add www-data ... httpd-rootless-with-user

Or, run with the Docker Compose equivalent (see the accompanying `docker-compose.yml` file).

Notes:

* A user account, and optionally a user group, must be specified in the image,
  and must have a corresponding entry when the container is started via Docker
  Compose or `docker run`. The user & group must match.  Contrast this to the
  [httpd-rootless][1] image, which only needs a UserID & GroupID in the Docker
  Compose/`docker run`.

[1]: https://github.com/NERSC/spin-recipes/tree/master/httpd-rootless
