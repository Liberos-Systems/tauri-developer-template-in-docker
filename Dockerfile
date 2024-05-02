FROM amd64/rust:1.77.2-bookworm

ENV DISPLAY=:0

RUN apt-get update
RUN apt-get install -y pkg-config
RUN apt-get install -y libssl-dev
RUN apt-get install -y libglib2.0-dev
RUN apt-get install -y libcairo2-dev
RUN apt-get install -y libgdk-pixbuf2.0-dev
RUN apt-get install -y libpango1.0-dev
RUN apt-get install -y libatk1.0-dev
RUN apt-get install -y libglib2.0-0
RUN apt-get install -y libwebkit2gtk-4.0-dev
RUN apt-get install -y build-essential
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y file
RUN apt-get install -y libgtk-3-dev
RUN apt-get install -y libayatana-appindicator3-dev
RUN apt-get install -y librsvg2-dev
RUN apt-get install -y librust-glib-sys-dev
RUN apt-get install -y librust-gobject-sys-dev
RUN apt-get install -y libjavascriptcoregtk-4.1-dev
RUN apt-get install -y libwebkit2gtk-4.1-dev
RUN apt-get install -y libsoup-3.0-0
RUN apt-get install -y mesa-utils
RUN apt-get install -y libgl1-mesa-dri
RUN apt-get install -y libgl1-mesa-glx

# Installing locale sources
RUN apt-get install -y locales
# Setting default locale to en_US.UTF-8
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8
# Installing necessary packages
RUN apt-get install -y dbus-x11 libcanberra-gtk-module libcanberra-gtk3-module chromium
# Generating a unique identifier for the container
RUN  dbus-uuidgen > /etc/machine-id

ENV NODE_VERSION=20.12.2
ENV NVM_DIR=/root/.nvm

# Installing nvm, Node.js, and Yarn
RUN apt-get update && apt-get install -y curl

# Downloading and installing NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Installing Node.js and Yarn
RUN . "$NVM_DIR/nvm.sh" && \
    nvm install ${NODE_VERSION} && \
    nvm use v${NODE_VERSION} && \
    npm install -g yarn

# Using Node.js
RUN . "$NVM_DIR/nvm.sh" && \
    nvm use v${NODE_VERSION}

# Setting the default version of Node.js
RUN . "$NVM_DIR/nvm.sh" && \
    nvm alias default v${NODE_VERSION}

# Setting the PATH environment variable
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

WORKDIR /tauri
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
