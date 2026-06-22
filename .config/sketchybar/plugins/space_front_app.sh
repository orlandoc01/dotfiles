#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icon_map.sh"

FOCUSED_APP="$INFO"
[ -n "$FOCUSED_APP" ] || exit 0

ACTIVE_SPACE=$(yabai -m query --spaces --space 2>/dev/null | jq -r '.index')
[ -n "$ACTIVE_SPACE" ] || exit 0

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
$(yabai -m query --windows 2>/dev/null | jq -r --argjson sid "$ACTIVE_SPACE" '[.[] | select(.space == $sid) | .app] | unique[]')
APPS

FOCUSED_DRAWING=off; [ -n "$FOCUSED_ICON" ] && FOCUSED_DRAWING=on
APPS_WIDTH=10; [ -n "$OTHER_ICONS" ] && APPS_WIDTH=dynamic
sketchybar --set "space.${ACTIVE_SPACE}"         drawing=on icon.color=$BLACK \
           --set "space.${ACTIVE_SPACE}.focused" label="$FOCUSED_ICON" drawing=$FOCUSED_DRAWING \
           --set "space.${ACTIVE_SPACE}.apps"    label="${OTHER_ICONS}" drawing=on width=$APPS_WIDTH
