#!/usr/bin/env sh

# Front-facing app name (right side, leftmost of the right group). Shows the
# title of the currently focused application; updated on front_app_switched by
# plugins/front_app.sh.
sketchybar --add       item         front_app right                   \
           --set       front_app    script="$PLUGIN_DIR/front_app.sh" \
                                    icon.drawing=off                  \
                                    label.color=$WHITE                \
                                    label.font="$FONT:Black:12.0"     \
                                    label.padding_left=15             \
                                    label.padding_right=15            \
           --subscribe front_app    front_app_switched

# Startup: seed the label from the currently focused app so the slot isn't
# blank until the next front_app_switched event after a reload.
FRONT_APP=$(yabai -m query --windows --window 2>/dev/null | jq -r '.app // empty')
[ -n "$FRONT_APP" ] && sketchybar --set front_app label="$FRONT_APP"
