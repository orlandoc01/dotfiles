#!/usr/bin/env sh
#
# Shared helpers for the space.* plugins. Callers must have already sourced
# colors.sh (for $BLACK/$GREY) and icon_map.sh (for __icon_map). Every space-icon
# plugin builds the same per-space icon strings and renders the same three
# sub-items, so that logic lives here once.

# Reads app names (one per line) on stdin and, given the focused app name,
# populates three globals consumed by the render helpers below:
#   FOCUSED_ICON  the focused app's glyph (empty if it has none / isn't present)
#   OTHER_ICONS   glyphs for every other app in the space
#   ALL_ICONS     glyphs for every app in the space (focused included)
collect_icons() {
  _focused_app="$1"
  FOCUSED_ICON=""
  OTHER_ICONS=""
  ALL_ICONS=""
  while IFS= read -r app; do
    [ -n "$app" ] || continue
    __icon_map "$app"
    [ "$icon_result" = ":default:" ] && continue
    ALL_ICONS="$ALL_ICONS$icon_result"
    if [ "$app" = "$_focused_app" ]; then
      FOCUSED_ICON="$icon_result"
    else
      OTHER_ICONS="$OTHER_ICONS$icon_result"
    fi
  done
}

# Render the active space <sid>: number in BLACK, the focused glyph, and the
# other apps' glyphs. Uses FOCUSED_ICON / OTHER_ICONS from collect_icons.
render_active() {
  _focused_drawing=off; [ -n "$FOCUSED_ICON" ] && _focused_drawing=on
  _apps_width=10;       [ -n "$OTHER_ICONS" ] && _apps_width=dynamic
  sketchybar --set "space.$1"         drawing=on icon.color=$BLACK \
             --set "space.$1.focused" label="$FOCUSED_ICON" drawing=$_focused_drawing \
             --set "space.$1.apps"    label="$OTHER_ICONS" drawing=on width=$_apps_width
}

# Render an inactive space <sid>: number in GREY, no focused glyph, all glyphs.
# Uses ALL_ICONS from collect_icons.
render_inactive() {
  _apps_width=10; [ -n "$ALL_ICONS" ] && _apps_width=dynamic
  sketchybar --set "space.$1"         drawing=on icon.color=$GREY \
             --set "space.$1.focused" label="" drawing=off \
             --set "space.$1.apps"    label="$ALL_ICONS" drawing=on width=$_apps_width
}
