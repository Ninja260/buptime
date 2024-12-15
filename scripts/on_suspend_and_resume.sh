#!/bin/bash

# call to log suspend or resume

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

logsr="$CWD/logsr.sh"

if [[ "${CWD##*/}" == "system-sleep" ]]; then
  logsr="/etc/scripts/buptime/logsr.sh"
fi

case "$1" in
pre)
  "$logsr" suspend
  ;;
post)
  "$logsr" resume
  ;;
*)
  # nothing
  ;;
esac
