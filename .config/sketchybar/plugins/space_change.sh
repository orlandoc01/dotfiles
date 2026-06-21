#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icon_map.sh"

if [ "$SELECTED" = "true" ]; then
  FOCUSED_APP=$(yabai -m query --windows --window 2>/dev/null | jq -r '.app // empty')
  FOCUSED_ICON=""
  OTHER_ICONS=""

  while IFS= read -r app; do
    [ -n "$app" ] || continue
    __icon_map "$app"
    [ "$icon_result" = ":default:" ] && continue
    if [ "$app" = "$FOCUSED_APP" ]; then
      FOCUSED_ICON="$icon_result"
    else
      OTHER_ICONS="$OTHER_ICONS$icon_result"
    fi
  done <<APPS
$(yabai -m query --windows 2>/dev/null | jq -r --argjson sid "$SID" '[.[] | select(.space == $sid) | .app] | unique[]')
APPS

  DRAWING=off; [ -n "$FOCUSED_ICON" ] && DRAWING=on
  sketchybar --set "${NAME}.focused" label="$FOCUSED_ICON" drawing=$DRAWING \
             --set "${NAME}.apps"    label="${OTHER_ICONS}"
else
  ALL_ICONS=""

  while IFS= read -r app; do
    [ -n "$app" ] || continue
    __icon_map "$app"
    [ "$icon_result" = ":default:" ] && continue
    ALL_ICONS="$ALL_ICONS$icon_result"
  done <<APPS
$(yabai -m query --windows 2>/dev/null | jq -r --argjson sid "$SID" '[.[] | select(.space == $sid) | .app] | unique[]')
APPS

  sketchybar --set "${NAME}.focused" label="" drawing=off \
             --set "${NAME}.apps"    label="${ALL_ICONS}"
fi
