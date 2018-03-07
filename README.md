# Docker image: Cloud9 IDE in CentOS 7	
Running cloud9 on centos/nodejs8


Usage:
```
docker run -e  SEMAPHORE_BRANCH=master \
           -e OUTPUT_USER=johndoe \
           -e OUTPUT_GROUP=users \
           -v ${PWD}:/output \
           registry.ott-consult.de/oc/semaphore-build
```
