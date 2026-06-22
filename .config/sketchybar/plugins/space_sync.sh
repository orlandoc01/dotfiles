#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icon_map.sh"

WINDOWS=$(yabai -m query --windows 2>/dev/null)
SPACES_JSON=$(yabai -m query --spaces 2>/dev/null)
ACTIVE_SPACE=$(echo "$SPACES_JSON" | jq -r '.[] | select(.["has-focus"] == true) | .index')
FOCUSED_APP=$(yabai -m query --windows --window 2>/dev/null | jq -r '.app // empty')

for sid in $(seq 1 10); do
  EXISTS=$(echo "$SPACES_JSON" | jq -r --argjson sid "$sid" 'map(select(.index == $sid)) | length')

  if [ "$EXISTS" = "0" ]; then
    sketchybar --set "space.$sid"         drawing=off \
               --set "space.$sid.focused" drawing=off label="" \
               --set "space.$sid.apps"    drawing=off label=""
    continue
  fi

  FOCUSED_ICON=""
  OTHER_ICONS=""
  ALL_ICONS=""

  while IFS= read -r app; do
    [ -n "$app" ] || continue
    __icon_map "$app"
    [ "$icon_result" = ":default:" ] && continue
    ALL_ICONS="$ALL_ICONS$icon_result"
    if [ "$sid" = "$ACTIVE_SPACE" ] && [ "$app" = "$FOCUSED_APP" ]; then
      FOCUSED_ICON="$icon_result"
    elif [ "$sid" = "$ACTIVE_SPACE" ]; then
      OTHER_ICONS="$OTHER_ICONS$icon_result"
    fi
  done <<APPS
$(echo "$WINDOWS" | jq -r --argjson sid "$sid" '[.[] | select(.space == $sid) | .app] | unique[]')
APPS

  if [ "$sid" = "$ACTIVE_SPACE" ]; then
    FOCUSED_DRAWING=off
    [ -n "$FOCUSED_ICON" ] && FOCUSED_DRAWING=on
    APPS_WIDTH=10
    [ -n "$OTHER_ICONS" ] && APPS_WIDTH=dynamic
    sketchybar --set "space.$sid"         drawing=on icon.color=$BLACK \
               --set "space.$sid.focused" label="$FOCUSED_ICON" drawing=$FOCUSED_DRAWING \
               --set "space.$sid.apps"    label="$OTHER_ICONS" drawing=on width=$APPS_WIDTH
  else
    APPS_WIDTH=10
    [ -n "$ALL_ICONS" ] && APPS_WIDTH=dynamic
    sketchybar --set "space.$sid"         drawing=on icon.color=$GREY \
               --set "space.$sid.focused" label="" drawing=off \
               --set "space.$sid.apps"    label="$ALL_ICONS" drawing=on width=$APPS_WIDTH
  fi
done
