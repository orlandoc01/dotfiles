#!/usr/bin/env bash
#
# Mouse/popup handler for the media_ctrl widget. The actual now-playing display
# is driven by plugins/media_stream.sh; this script only reacts to clicks and
# hover, so there is no polling here. Control presses go through media-control;
# the resulting state change is pushed back by the stream.

MC=/opt/homebrew/bin/media-control

mouse_clicked() {
  case "$NAME" in
    "media_ctrl.next") "$MC" next-track ;;
    "media_ctrl.back") "$MC" previous-track ;;
    "media_ctrl.play") "$MC" toggle-play-pause ;;
  esac
}

popup() {
  sketchybar --set media_ctrl.anchor popup.drawing="$1"
}

case "$SENDER" in
  "mouse.clicked")                      mouse_clicked ;;
  "mouse.entered")                      popup on ;;
  "mouse.exited"|"mouse.exited.global") popup off ;;
  *)                                    : ;;
esac
