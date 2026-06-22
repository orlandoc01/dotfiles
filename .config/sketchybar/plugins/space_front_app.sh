#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icon_map.sh"
source "$HOME/.config/sketchybar/plugins/space_common.sh"

FOCUSED_APP="$INFO"
[ -n "$FOCUSED_APP" ] || exit 0

ACTIVE_SPACE=$(yabai -m query --spaces --space 2>/dev/null | jq -r '.index')
[ -n "$ACTIVE_SPACE" ] || exit 0

collect_icons "$FOCUSED_APP" <<APPS
$(yabai -m query --windows 2>/dev/null | jq -r --argjson sid "$ACTIVE_SPACE" '[.[] | select(.space == $sid) | .app] | unique[]')
APPS
render_active "$ACTIVE_SPACE"
