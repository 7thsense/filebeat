FROM 7thsense/java:8
MAINTAINER Erik LaBianca <erik@7thsense.io>

ADD beats.repo /etc/yum.repos.d
ADD docker-entrypoint.sh /
ADD bootstrap.sh /root/bootstrap.sh
RUN /root/bootstrap.sh && rm /root/bootstrap.sh && chmod a+x /docker-entrypoint.sh

VOLUME /var/log

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 9200 9300

CMD ["filebeat"]
WORKDIR /var/log

