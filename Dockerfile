FROM zenika/alpine-chrome:with-node

USER root
RUN apk add --no-cache bash xvfb xvfb-run

USER chrome
WORKDIR /usr/src/app
COPY --chown=chrome app/package.json app/yarn.lock ./

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD 1
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser

RUN yarn
COPY --chown=chrome ./app script.sh ./
EXPOSE 3000

ENTRYPOINT ["tini", "--"]
CMD bash script.sh