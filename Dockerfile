FROM zenika/alpine-chrome:with-node
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD 1
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser

USER root
RUN apk add --no-cache bash xvfb xvfb-run

USER chrome
WORKDIR /usr/src/app
COPY --chown=chrome app/package.json app/yarn.lock ./
RUN yarn
COPY --chown=chrome ./app script.sh ./
ENTRYPOINT ["tini", "--"]