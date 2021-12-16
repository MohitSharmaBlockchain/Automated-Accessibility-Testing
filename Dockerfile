FROM alpine:3.13

RUN apk add --update \
  git \
  nodejs \
  npm;

# Installing Chromium
RUN apk update && apk upgrade && \
    apk add \
    chromium \
    freetype \
    harfbuzz \
    nss \
    ttf-freefont \
    # To have same executablePath in config.json as for stretch.
    && ln -s /usr/bin/chromium-browser /usr/bin/chromium \
    && rm -rf /var/cache/apk/*

# Tell Puppeteer to skip installing Chrome. We'll be using the chromium package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Installing pa11y-ci npm package
RUN	npm install -g \
    pa11y-ci@2.* \
    depcheck \
    --unsafe-perm \
    && npm cache clean --force
