#!/bin/bash

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

logsr="$CWD/logsr.sh"

while true; do
  signal=$(cat "$CWD/resumed")
  if [[ $signal == "1" ]]; then
    "$logsr" resume

    truncate -s 0 "$CWD/resumed"
  fi

  sleep 5
done
