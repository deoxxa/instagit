#!/bin/bash

[ -e ~/.instagit ] && . ~/.instagit;

if [ "x${SSH_ORIGINAL_COMMAND}" = "x" ]; then
  echo "This script should be run via ssh" >&2;
  exit 1;
fi;

eval set -- ${SSH_ORIGINAL_COMMAND};

case ${1} in
  git-receive-pack|git-upload-pack|git-upload-archive) ;;
  *) echo "Invalid command!" >&2; exit 1; ;;
esac;

if [ "x${INSTAGIT_STORE}" = "x" ]; then
  echo "Necessary environment variables not set!" >&2;
  exit 1;
fi;

REPO="${INSTAGIT_STORE}/${2}";

if [ ! -d "${REPO}" ]; then
  mkdir -p "${REPO}";
  cd "${REPO}";
  git init --bare >&2;
fi;

cd "${INSTAGIT_STORE}";

eval exec ${SSH_ORIGINAL_COMMAND};