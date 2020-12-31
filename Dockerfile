FROM node:15

ENV YARN_CACHE_FOLDER /yarn

RUN apt-get update && apt-get install -yq \
  # https
  ca-certificates \
  # libraries
  libappindicator1 libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
  # tools
  gconf-service lsb-release wget xdg-utils\
  # fonts
  fonts-liberation\
  # system stuff
  time dumb-init

WORKDIR /app

COPY ./app/package.json ./app/yarn.lock ./

RUN mkdir -p $YARN_CACHE_FOLDER && \
    yarn config set cache-folder $YARN_CACHE_FOLDER &&\
    yarn install

COPY ./app/* ./

COPY ./script.sh ./
