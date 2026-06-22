#!/usr/bin/env bash

NPC=/opt/homebrew/bin/nowplaying-cli

source "$HOME/.config/sketchybar/icon_map.sh"

next() { $NPC next; }
back() { $NPC previous; }
play() { $NPC togglePlayPause; }

# Returns the display name of the currently playing audio app.
get_playing_app_name() {
  local apps=(
    "Spotify"
    "Music"
    "Podcasts"
    "Overcast"
    "Google Chrome"
    "Arc"
    "Safari"
    "Firefox"
    "Brave Browser"
  )
  for name in "${apps[@]}"; do
    pgrep -f "$name" > /dev/null 2>&1 && echo "$name" && return
  done
}

update() {
  TRACK="$($NPC get title)"
  if [ "$TRACK" = "null" ] || [ -z "$TRACK" ]; then
    sketchybar -m --set media_ctrl.anchor   drawing=off \
                  --set media_ctrl.app_icon drawing=off
    return
  fi

  ARTIST="$($NPC get artist)"
  ALBUM="$($NPC get album)"
  PLAYBACK_RATE="$($NPC get playbackRate)"
  MEDIA="$TRACK - $ARTIST"

  if [ "$PLAYBACK_RATE" != "1" ]; then
    PLAY_ICON=􀊄
  else
    PLAY_ICON=􀊆
  fi

  $NPC get artworkData | base64 --decode > /tmp/cover.jpg 2>/dev/null

  APP_NAME=$(get_playing_app_name)
  __icon_map "$APP_NAME"
  if [ -n "$icon_result" ] && [ "$icon_result" != ":default:" ]; then
    sketchybar --set media_ctrl.app_icon label="$icon_result" drawing=on
  else
    sketchybar --set media_ctrl.app_icon drawing=off
  fi

  if [ -z "$ARTIST" ]; then
    sketchybar -m \
      --set media_ctrl.title  label="$TRACK" \
      --set media_ctrl.album  label="Podcast" \
      --set media_ctrl.artist label="$ALBUM" \
      --set media_ctrl.play   icon="$PLAY_ICON" \
      --set media_ctrl.cover  background.image="/tmp/cover.jpg" background.color=0x00000000 \
      --set media_ctrl.anchor label="$MEDIA" drawing=on
  else
    sketchybar -m \
      --set media_ctrl.title  label="$TRACK" \
      --set media_ctrl.album  label="$ALBUM" \
      --set media_ctrl.artist label="$ARTIST" \
      --set media_ctrl.play   icon="$PLAY_ICON" \
      --set media_ctrl.cover  background.image="/tmp/cover.jpg" background.color=0x00000000 \
      --set media_ctrl.anchor label="$MEDIA" drawing=on
  fi
}

mouse_clicked() {
  case "$NAME" in
    "media_ctrl.next") next; sleep 0.4; update ;;
    "media_ctrl.back") back; sleep 0.4; update ;;
    "media_ctrl.play") play; sleep 0.2; update ;;
    *) exit ;;
  esac
}

popup() {
  sketchybar --set media_ctrl.anchor popup.drawing="$1"
}

case "$SENDER" in
  "mouse.clicked")                      mouse_clicked ;;
  "mouse.entered")                      popup on ;;
  "mouse.exited"|"mouse.exited.global") popup off ;;
  "forced")                             exit 0 ;;
  *)                                    update ;;
esac
