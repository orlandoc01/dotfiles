#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icon_map.sh"
source "$HOME/.config/sketchybar/plugins/space_common.sh"

APP_LIST=$(yabai -m query --windows 2>/dev/null | jq -r --argjson sid "$SID" '[.[] | select(.space == $sid) | .app] | unique[]')

if [ "$SELECTED" = "true" ]; then
  FOCUSED_APP=$(yabai -m query --windows --window 2>/dev/null | jq -r '.app // empty')
  collect_icons "$FOCUSED_APP" <<APPS
$APP_LIST
APPS
  render_active "$SID"
else
  collect_icons "" <<APPS
$APP_LIST
APPS
  render_inactive "$SID"
fi
