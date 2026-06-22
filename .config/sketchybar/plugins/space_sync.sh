#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icon_map.sh"
source "$HOME/.config/sketchybar/plugins/space_common.sh"

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

  APP_LIST=$(echo "$WINDOWS" | jq -r --argjson sid "$sid" '[.[] | select(.space == $sid) | .app] | unique[]')

  if [ "$sid" = "$ACTIVE_SPACE" ]; then
    collect_icons "$FOCUSED_APP" <<APPS
$APP_LIST
APPS
    render_active "$sid"
  else
    collect_icons "" <<APPS
$APP_LIST
APPS
    render_inactive "$sid"
  fi
done
