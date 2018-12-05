FROM ubuntu:trusty

ENV POSTGREST_VERSION 0.4.4.0

RUN apt-get update && apt-get install --no-install-recommends -y xz-utils curl libpq-dev libgmp10 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -L --insecure https://github.com/PostgREST/postgrest/releases/download/v0.4.4.0/postgrest-v0.4.4.0-ubuntu.tar.xz    | tar -xJO > /usr/local/bin/postgrest \
    && chmod u+x /usr/local/bin/postgrest 

COPY postgrest.conf /etc/postgrest.conf


ENV DBHOST= \
    DBNAME= \
    DBPORT= \
    DBUSER= \
    DBPASS= \
    SCHEMA=public \
    ANONUSER= \
    DBPOOL=100 \
    PGRST_SERVER_HOST=*4 \
    PORT=3000 \
    PGRST_SERVER_PROXY_URI= \
    PGRST_JWT_SECRET= \
    PGRST_SECRET_IS_BASE64=false \
    PGRST_JWT_AUD= \
    PGRST_MAX_ROWS= \
    PGRST_PRE_REQUEST= \
    PGRST_ROLE_CLAIM_KEY=".role"

# PostgREST reads /etc/postgrest.conf so map the configuration
# file in when you run this container
CMD exec postgrest /etc/postgrest.conf

EXPOSE 3000


#CMD ["sh", "-c", "postgrest", "--db-name", "postgres", "--db-port", "5432", "--db-user", "postgres", "--db-pass", "$POSTGRES_PASSWORD", "--db-host", "postgis", "--db-pool", "200", "-a", "postgres"]
