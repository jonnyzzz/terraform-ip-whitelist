#!/bin/bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(cd "$DIR" && cd ../.. && pwd)"

if [[ "${TEAMCITY_VERSION:-}" != "" ]] ; then
  set -e -x -u
fi

DOCKER_ARGS="${DOCKER_ARGS:-}"

if [[ -d ~/.aws ]] ; then
  DOCKER_ARGS="${DOCKER_ARGS} --volume $(cd ~/.aws && pwd):/root/.aws:ro "
fi

if [[ "${TEAMCITY_VERSION:-}" != "" ]] ; then
  docker pull ${DOCKER_IMAGE} >&2
fi

if [[ -t 1 ]] ; then
  DOCKER_ARGS="${DOCKER_ARGS} -it "
fi

for key in AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_DEFAULT_REGION AWS_DEFAULT_PROFILE ; do
  value=$(eval echo "\${${key}:-}")
  if [[ "$value" != "" ]] ; then
    DOCKER_ARGS="${DOCKER_ARGS} --env $key=$value "
  fi
done


docker run \
          --rm \
          ${DOCKER_ARGS}  \
          --volume "$PROJECT_ROOT:$PROJECT_ROOT" \
          --workdir "$(pwd)"  \
          ${DOCKER_IMAGE} \
          $*

