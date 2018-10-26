FROM elixir:1.7.3-alpine

RUN apk --update add nodejs \
  yaml-dev

RUN mkdir /app
ADD . /app
WORKDIR /app

RUN MIX_ENV=prod mix deps.get
RUN MIX_ENV=prod mix ecto.setup

ENV PORT 4000
EXPOSE 4000

CMD ["mix","phx.server"]
