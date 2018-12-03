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
* Includes modifications to obtain the client IP address from a reverse
  proxy, as typically implemented in Spin.
* If you look at the running container, you will see that ports 80 &
  8080 are both `EXPOSE`d bu Docker. That is because the parent image already
  has a statement that says `EXPOSE 80`, while here in the child image we add
  `EXPOSE 8080`. However, nothing is actually listening on port 80.

[1]: https://github.com/NERSC/spin-recipes/tree/master/httpd-rootless
