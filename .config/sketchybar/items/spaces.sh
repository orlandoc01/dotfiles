#!/usr/bin/env sh

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add space      space.$sid left                              \
             --set space.$sid associated_space=$sid                        \
                              click_script="$SPACE_CLICK_SCRIPT"           \
                              script="$PLUGIN_DIR/space_windows.sh"        \
                              icon=${SPACE_ICONS[i]}                       \
                              icon.color=$BLACK                            \
                              icon.font="$FONT:Black:12.0"                 \
                              icon.padding_left=22                         \
                              icon.padding_right=6                         \
                              icon.highlight_color=$GREY                   \
                              label.font="sketchybar-app-font:Regular:16.0" \
                              label.color=$GREY                            \
                              label.highlight_color=$WHITE                 \
                              label.padding_left=0                         \
                              label.padding_right=14                       \
                              label.y_offset=-1                            \
                              background.padding_left=-8                   \
                              background.padding_right=-8                  \
                              background.height=26                         \
                              background.corner_radius=9                   \
                              background.color=0xffb8c0e0                  \
                              background.drawing=on
  sketchybar --subscribe space.$sid space_windows_change
done

# Populate app icons and highlight state from current yabai state on startup
source "$HOME/.config/sketchybar/icon_map.sh"
WINDOWS=$(yabai -m query --windows 2>/dev/null)
ACTIVE_SPACE=$(yabai -m query --spaces --space 2>/dev/null | jq -r '.index')
for sid in $(seq 1 10); do
  ICON_LINE=""
  while IFS= read -r app; do
    [ -n "$app" ] || continue
    __icon_map "$app"
    ICON_LINE="$ICON_LINE$icon_result"
  done <<APPS
$(echo "$WINDOWS" | jq -r --argjson sid "$sid" '[.[] | select(.space == $sid) | .app] | unique[]')
APPS
  [ -n "$ICON_LINE" ] || ICON_LINE=" —"
  if [ "$sid" = "$ACTIVE_SPACE" ]; then
    sketchybar --set "space.$sid" label="$ICON_LINE" icon.highlight=on label.highlight=on
  else
    sketchybar --set "space.$sid" label="$ICON_LINE" icon.highlight=off label.highlight=off
  fi
done

sketchybar   --add item       separator left                          \
             --set separator  icon=                                  \
                              icon.font="Hack Nerd Font:Regular:16.0" \
                              background.padding_left=26              \
                              background.padding_right=15             \
                              label.drawing=off                       \
                              icon.color=$WHITE
