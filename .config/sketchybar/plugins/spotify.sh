#!/usr/bin/env sh
RUNNING=$(osascript -e 'if application "Spotify" is running then return 0')
if [ "$RUNNING" == "" ]; then
  RUNNING=1
fi
PLAYING=1
TRACK=""
if [ "$(osascript -e 'if application "Spotify" is running then tell application "Spotify" to get player state')" == "playing" ]; then
  PLAYING=0
  TRACK=$(osascript -e 'tell application "Spotify" to get name of current track')
fi
if [ $RUNNING -eq 0 ] && [ $PLAYING -eq 0 ]; then
  sketchybar --set spot label="􀑪 $TRACK" --set '/spot.*/' drawing=on
else
  sketchybar --set '/spot.*/' drawing=off
fi
