#!/usr/bin/env bash

isMute=$( /usr/bin/osascript -e 'output muted of (get volume settings)' )

if [ "$isMute" == "true" ]; then
  echo "muted"
elif [ "$isMute" = "missing value" ]; then
  echo "muted"
else
  curVolume=$(osascript -e 'output volume of (get volume settings)')
  echo $curVolume
fi
