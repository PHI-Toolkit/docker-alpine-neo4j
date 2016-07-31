# source of base: https://github.com/thetallgrassnet/alpine-java/tree/master/8
# Dockerfile source: https://github.com/thetallgrassnet/alpine-neo4j/blob/master/3.0.0-M05-enterprise/Dockerfile

FROM hermantolentino/docker-alpine-java:v1

RUN apk add --quiet --update bash curl \
    && curl --fail --silent --show-error --location --output lsof.apk http://dl-3.alpinelinux.org/alpine/v3.0/main/x86_64/lsof-4.87-r0.apk \
    && apk add --quiet --allow-untrusted lsof.apk \
    && rm lsof.apk \
    && rm -rf /var/cache/apk/*

ENV NEO4J_VERSION 3.0.0-M05
ENV NEO4J_EDITION community
ENV NEO4J_DOWNLOAD_SHA256 2b7878f424859de6951e86f9abb71701d8d45ab22e1157410504fe6a6bb17a95
ENV NEO4J_DOWNLOAD_ROOT http://dist.neo4j.org
ENV NEO4J_TARBALL neo4j-$NEO4J_EDITION-$NEO4J_VERSION-unix.tar.gz
ENV NEO4J_URI $NEO4J_DOWNLOAD_ROOT/$NEO4J_TARBALL

RUN curl --fail --silent --show-error --location --output neo4j.tar.gz $NEO4J_URI \
    && echo "$NEO4J_DOWNLOAD_SHA256  neo4j.tar.gz" | sha256sum -c -s - \
    && tar -xzf neo4j.tar.gz -C /var/lib \
    && mv /var/lib/neo4j-* /var/lib/neo4j \
    && rm neo4j.tar.gz

WORKDIR /var/lib/neo4j

RUN mv data /data
#    && ln -s /data

# disable authentication
#RUN sed -i 's/auth_enabled=true/auth_enabled=false/g' conf/neo4j.conf
#RUN sed -i 's/# dbms.connector.0.address=0.0.0.0:7687/dbms.connector.0.address=0.0.0.0:7687/g' conf/neo4j.conf
#RUN sed -i 's/#remote_shell_port=1337/remote_shell_port=1337/g' conf/neo4j.conf

VOLUME /data

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod a+x /docker-entrypoint.sh

EXPOSE 7474 7473 7687 1337

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["neo4j"]
