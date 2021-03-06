#!/usr/bin/env bash

# This is a bash utility to test the script in docker container
# Version:1.0
# Author: Prasad Tengse
# Licence: GPLv3
# Github Repository: https://github.com/tprasadtp/after-effects-ubuntu

set -o pipefail

function main()
{
  if [[ $# -lt 2 ]]; then
    echo "You need to specify distro name & release name"
    exit 1
  fi


  distro="$1"
  release="$2"


  docker_tag="${distro//[\/]/-}-${release}"
  shift 2
  echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

  echo "Building $distro:$release Docker Image"
  docker build -t ae:"${docker_tag}" \
    --build-arg DISTRO="${distro}" \
    --build-arg CODE_NAME="${release}"  \
    ./tests/docker
  docker run --rm \
    --userns=host \
    -it \
    -e CI \
    -e DEBUG \
    -e GITHUB_ACTIONS \
    -e AE_INTERNAL_NO_EXECUTE \
    --hostname="${docker_tag}" \
    -v "$(pwd)":/shared \
    ae:"${docker_tag}" \
    ./after-effects \
    --simulate \
    "$@"
    exit_code="$?"

  echo ""
  echo ""
  echo "Exit code is $exit_code"
  if [[ $exit_code -ne 0 ]]; then
    exit "$exit_code"
  fi

}

main "$@"
