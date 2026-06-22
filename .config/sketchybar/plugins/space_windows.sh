#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icon_map.sh"

CHANGED_SPACE=$(echo "$INFO" | jq -r '.space')
ACTIVE_SPACE=$(yabai -m query --spaces --space 2>/dev/null | jq -r '.index')

if [ "$CHANGED_SPACE" = "$ACTIVE_SPACE" ]; then
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
$(echo "$INFO" | jq -r '.apps | keys[]')
APPS

  FOCUSED_DRAWING=off; [ -n "$FOCUSED_ICON" ] && FOCUSED_DRAWING=on
  APPS_WIDTH=10; [ -n "$OTHER_ICONS" ] && APPS_WIDTH=dynamic
  sketchybar --set "space.${CHANGED_SPACE}"         drawing=on icon.color=$BLACK \
             --set "space.${CHANGED_SPACE}.focused" label="$FOCUSED_ICON" drawing=$FOCUSED_DRAWING \
             --set "space.${CHANGED_SPACE}.apps"    label="${OTHER_ICONS}" drawing=on width=$APPS_WIDTH
else
  ALL_ICONS=""

  while IFS= read -r app; do
    [ -n "$app" ] || continue
    __icon_map "$app"
    [ "$icon_result" = ":default:" ] && continue
    ALL_ICONS="$ALL_ICONS$icon_result"
  done <<APPS
$(echo "$INFO" | jq -r '.apps | keys[]')
APPS

  APPS_WIDTH=10; [ -n "$ALL_ICONS" ] && APPS_WIDTH=dynamic
  sketchybar --set "space.${CHANGED_SPACE}"         drawing=on icon.color=$GREY \
             --set "space.${CHANGED_SPACE}.focused" label="" drawing=off \
             --set "space.${CHANGED_SPACE}.apps"    label="${ALL_ICONS}" drawing=on width=$APPS_WIDTH
fi
