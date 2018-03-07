#!/bin/bash
set -e
set -x

function install_go() {
    curl -jkLsS  -o /tmp/go.tar.gz https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz
    tar -C /usr/local -xzf /tmp/go.tar.gz
    echo 'export PATH=$PATH:/usr/local/go/bin' >>/etc/profile
    export PATH=$PATH:/usr/local/go/bin
}

chmod a+rwx /tmp
source /tmp/install/functions.sh

install_software git glibc-static gcc make
create_user_and_group
install_go
mkdir -p "${APP_HOME}/go/src/github.com/joernott" "${APP_HOME}/go/bin" "${APP_HOME}/go/pkg"
chown -R ${APP_USER}:${APP_GROUP} "${APP_HOME}/go"
cd "${APP_HOME}/go/src/github.com/joernott"
gosu ${APP_USER}:${APP_GROUP} git clone --recursive https://github.com/joernott/semaphore.git
cd semaphore
gosu ${APP_USER}:${APP_GROUP} go get ./... github.com/cespare/reflex github.com/jteeuwen/go-bindata/... github.com/mitchellh/gox
npm install -g async
npm install -g nodemon pug-cli less
mkdir /output
touch /output/not_mounted
cleanup

