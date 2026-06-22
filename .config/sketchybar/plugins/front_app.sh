#!/usr/bin/env sh

# Renders the focused application's name into the front_app item. The
# front_app_switched event delivers the new app name in $INFO.
case "$SENDER" in
  "front_app_switched")
    sketchybar --set "$NAME" label="$INFO"
    ;;
esac
