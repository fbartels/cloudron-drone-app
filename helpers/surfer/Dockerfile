FROM node:lts as build
# use --unsafe to not execute post actions as user nobody
RUN npm -g install cloudron-surfer@6.0.0 --unsafe && \
    npm cache clean --force && \
    surfer --version

FROM build as distrobox
# Install essential packages and locales
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-utils \
        bash \
        bash-completion \
        bc \
        curl \
        dialog \
        diffutils \
        findutils \
        gnupg2 \
        less \
        libegl1-mesa \
        libgl1-mesa-glx \
        libnss-myhostname \
        libvte-2.9*-common \
        libvte-common \
        libvulkan1 \
        locales \
        lsof \
        mesa-vulkan-drivers \
        ncurses-base \
        passwd \
        pinentry-curses \
        procps \
        sudo \
        time \
        tzdata \
        util-linux \
        wget

# make sure that the distrobox stage is not the last one
FROM build as surfer