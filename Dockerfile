FROM elixir:1.9.0-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base git python

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN HEX_MIRROR=https://hexpm.upyun.com mix do deps.get, deps.compile


# compile and build release
COPY priv priv
COPY lib lib
# uncomment COPY if rel/ exists
COPY rel rel

RUN mix do compile, release

# prepare release image
FROM alpine:3.9 AS app
RUN apk add --no-cache openssl ncurses-libs

WORKDIR /app
COPY entrypoint.sh .

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/checker ./

ENV HOME=/app

CMD ["/bin/sh", "/app/entrypoint.sh"]