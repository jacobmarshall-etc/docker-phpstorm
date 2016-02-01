FROM java:8-jre
MAINTAINER Jacob Marshall <jacob@manage.net.nz>

ENV PHPSTORM_VERSION 10.0.3
ENV PHPSTORM_URL https://d1opms6zj7jotq.cloudfront.net/webide
ENV PHPSTORM_HOME .WebIde100

RUN useradd -m -s /bin/bash developer && \
    mkdir -p "/home/developer/${PHPSTORM_HOME}" && \
    chown -R developer:developer /home/developer

WORKDIR /opt

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl git && \
    rm -rf /var/lib/apt/lists/*

RUN curl -SLO "${PHPSTORM_URL}/PhpStorm-${PHPSTORM_VERSION}.tar.gz" && \
    tar -xzf "PhpStorm-${PHPSTORM_VERSION}.tar.gz" && \
    mv PhpStorm-*/ phpstorm/ && \
    rm "PhpStorm-${PHPSTORM_VERSION}.tar.gz"

USER developer

ENTRYPOINT ["phpstorm/bin/phpstorm.sh"]
