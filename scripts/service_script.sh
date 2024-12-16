#!/bin/bash

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

# run "on_unplugged.sh" for the first service start
if [[ ! -e '/run/buptime' ]]; then
  "$CWD/on_unplugged.sh"

  touch /run/buptime
fi

logsr="$CWD/logsr.sh"

while true; do
  signal=$(cat "$CWD/resumed")
  if [[ $signal == "1" ]]; then
    "$logsr" resume

    truncate -s 0 "$CWD/resumed"
  fi

  sleep 5
done
