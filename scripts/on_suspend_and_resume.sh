#!/bin/bash

# call to log suspend or resume

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

program_path="$CWD"

if [[ "${CWD##*/}" == "system-sleep" ]]; then
  program_path="/etc/scripts/buptime"
fi

logsr="$program_path/logsr.sh"

case "$1" in
pre)
  "$logsr" suspend
  ;;
post)
  # signale the buptime.service to log the resume record after sometimes
  echo 1 >"$program_path/resumed"
  ;;
*)
  # nothing
  ;;
esac
