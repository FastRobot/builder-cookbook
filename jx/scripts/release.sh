#!/usr/bin/env bash
set -e
# ensure we're not on a detached head
git checkout master

# until we switch to the new kubernetes / jenkins credential implementation use git credentials store
git config credential.helper store

export VERSION="$(jx-release-version)"
echo "Releasing version to ${VERSION}"

docker build -t $DOCKER_REGISTRY/$ORG/$APP_NAME:${VERSION} .
docker push $DOCKER_REGISTRY/$ORG/$APP_NAME:${VERSION}
docker tag $DOCKER_REGISTRY/$ORG/$APP_NAME:${VERSION} docker.io/$ORG/$APP_NAME:latest
docker push $DOCKER_REGISTRY/$ORG/$APP_NAME

#jx step tag --version ${VERSION}
git tag -fa v${VERSION} -m "Release version ${VERSION}"
git push origin v${VERSION}

updatebot push-version --kind helm jenkinsxio/builder-go ${VERSION}
updatebot push-version --kind docker jenkinsxio/builder-go ${VERSION}
updatebot update-loop
