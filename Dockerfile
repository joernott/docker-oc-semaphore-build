FROM registry.ott-consult.de/oc/node8
LABEL MAINTAINER="joern.ott@ott-consult.de"

ENV APP_USER=semaphore \
    APP_UID=2006 \
    APP_GROUP=semaphore \
    APP_GID=2006 \
    APP_HOME=/build \
    GIT_COMMIT="x" \
    GO_VERSION=1.10 \
    OUTPUT_OWNER=white \
    OUTPUT_GROUP=users \
    SEMAPHORE_BRANCH=master \
    IMAGE_HISTORY="x"

COPY src /

RUN /tmp/install/oc-semaphore-build.sh

ENTRYPOINT /entrypoint
