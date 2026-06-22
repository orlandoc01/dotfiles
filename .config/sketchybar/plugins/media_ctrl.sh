#!/usr/bin/env bash
#
# Mouse handler for the media_ctrl widget. The now-playing display is driven by
# plugins/media_stream.sh; this script only reacts to clicks (no polling). The
# popup is toggled by the anchor's own click_script (popup.drawing=toggle); here
# we just route the control-button clicks. Control presses go through
# media-control; the resulting state change is pushed back by the stream.

MC=/opt/homebrew/bin/media-control

mouse_clicked() {
  case "$NAME" in
    "media_ctrl.next") "$MC" next-track ;;
    "media_ctrl.back") "$MC" previous-track ;;
    "media_ctrl.play") "$MC" toggle-play-pause ;;
  esac
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked ;;
  *)               : ;;
esac
