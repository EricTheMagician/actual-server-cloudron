FROM cloudron/base:3.2.0@sha256:ba1d566164a67c266782545ea9809dc611c4152e27686fd14060332dd88263ea

RUN mkdir -p /app/code /app/data
WORKDIR /app/code

ARG VERSION=1.0.3

# install actual-server
RUN curl -SL https://github.com/actualbudget/actual-server/archive/refs/tags/v${VERSION}.tar.gz | tar xzC . --strip-components 1 && \
    yarn install --production

COPY start,sh /app/code
CMD [ "/app/code/start.sh" ]
