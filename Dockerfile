FROM alpine:latest
RUN apk add --update openssh bash && rm -rf /var/cache/apk/*
RUN mkdir -p /root/.ssh

RUN passwd -u root

RUN mkdir -p /workdir
WORKDIR /workdir

ADD entrypoint.sh /workdir/
RUN chmod +x /workdir/*.sh

ADD sshd_config /workdir/

ENV LIFETIME=5m
EXPOSE 22/tcp
VOLUME [ "/workdir/authorized_keys" ]

ENTRYPOINT ["/workdir/entrypoint.sh"]

