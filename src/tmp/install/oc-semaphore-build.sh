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
cd "${APP_HOME}/go/src/github.com/joernott"
git clone --recursive https://github.com/joernott/semaphore.git
cd semaphore
# Workaround while my changes are not back in master
git checkout develop
FILES=$(find . -iname "*.go")
for FILE in ${FILES}; do
    sed -i ${FILE} -e 's|github.com/ansible-semaphore/semaphore|github.com/joernott/semaphore|g'
done
# End workaround
go get ./... github.com/cespare/reflex github.com/gobuffalo/packr/... github.com/mitchellh/gox
chown -R ${APP_USER}:${APP_GROUP} "${APP_HOME}/go"
npm install -g async
npm install -g nodemon pug-cli less
mkdir /output
touch /output/not_mounted
cleanup

