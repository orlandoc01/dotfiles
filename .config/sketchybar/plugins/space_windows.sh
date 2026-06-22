#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icon_map.sh"
source "$HOME/.config/sketchybar/plugins/space_common.sh"

CHANGED_SPACE=$(echo "$INFO" | jq -r '.space')
ACTIVE_SPACE=$(yabai -m query --spaces --space 2>/dev/null | jq -r '.index')
APP_LIST=$(echo "$INFO" | jq -r '.apps | keys[]')

if [ "$CHANGED_SPACE" = "$ACTIVE_SPACE" ]; then
  FOCUSED_APP=$(yabai -m query --windows --window 2>/dev/null | jq -r '.app // empty')
  collect_icons "$FOCUSED_APP" <<APPS
$APP_LIST
APPS
  render_active "$CHANGED_SPACE"
else
  collect_icons "" <<APPS
$APP_LIST
APPS
  render_inactive "$CHANGED_SPACE"
fi
