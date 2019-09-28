#!/bin/bash
set -eoux pipefail
DOCKER=$1

if [[ -n ${CI:-} && -n ${DOCKER_BUILDKIT:-} ]]; then
  ARG="--progress plain"
else
  ARG=
fi

for arch in amd64 armhf arm64; do
  if [[ -z ${DOCKER_BUILDKIT:-} ]]; then
    ARGS="$ARG --cache-from supersandro2000/kibitzr:$arch-latest"
  else
    ARGS=
  fi

  # shellcheck disable=SC2086
  $DOCKER build $ARGS --pull \
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg VCS_REF="$(git rev-parse --short HEAD)" \
    --build-arg VERSION="$(curl -s https://pypi.org/pypi/kibitzr/json | jq -r '.info.version')" \
    -f $arch.Dockerfile -t supersandro2000/kibitzr:$arch-latest .
done
