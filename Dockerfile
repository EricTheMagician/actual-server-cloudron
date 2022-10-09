FROM cloudron/base:3.2.0@sha256:ba1d566164a67c266782545ea9809dc611c4152e27686fd14060332dd88263ea

RUN mkdir -p /app/code /app/data && \
    chown -R cloudron:cloudron /app/data /app/code
WORKDIR /app/code

ARG VERSION=1.0.3
ENV ACTUAL_USER_FILES=/app/data  \
    NODE_ENV=production


# install actual-server
RUN curl -SL https://github.com/actualbudget/actual-server/archive/refs/tags/v${VERSION}.tar.gz | tar xzC /app/code --strip-components 1 && \
    cd /app/code && \
    yarn install --production && \
    # soft link from actual's location for data expection to where cloudron expects it
    ln -s /app/data /data

COPY start.sh /app/code
CMD [ "/app/code/start.sh" ]
