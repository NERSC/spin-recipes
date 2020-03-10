FROM nginx

RUN  \
    apt-get -y update && \
    apt-get -y install certbot python3-certbot-nginx curl procps vim


ADD . /src/
WORKDIR /src/

ENTRYPOINT [ "/src/entrypoint.sh" ]

CMD [ ]
