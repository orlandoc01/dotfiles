#!/usr/bin/env sh

# Yabai float-mode toggle (left, between the spaces pill and now-playing).
# Clicking it toggles the focused window between bsp and float; the glyph and
# color reflect the current layout state. All behavior lives in plugins/yabai.sh.
sketchybar --add       event        window_focus                      \
           --add       item         system.yabai left                 \
           --set       system.yabai script="$PLUGIN_DIR/yabai.sh"     \
                                    icon.font="$FONT:Bold:16.0"       \
                                    label.drawing=off                 \
                                    icon.width=30                     \
                                    icon=$YABAI_GRID                  \
                                    icon.color=$GREEN                 \
           --subscribe system.yabai window_focus mouse.clicked
