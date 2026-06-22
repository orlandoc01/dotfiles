#!/usr/bin/env sh

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  # Space number — no background (single shared bracket provides it)
  sketchybar --add space   space.$sid left                              \
             --set space.$sid associated_space=$sid                    \
                              script="$PLUGIN_DIR/space_change.sh"     \
                              icon=${SPACE_ICONS[i]}                   \
                              icon.font="$FONT:Black:12.0"             \
                              icon.color=$BLACK                        \
                              icon.padding_left=5                      \
                              icon.padding_right=5                     \
                              background.drawing=off                   \
                              background.padding_left=0                \
                              background.padding_right=0               \
                              label.drawing=off                        \
             --subscribe space.$sid space_change

  # Focused app icon (BLACK = same weight as the number)
  sketchybar --add item    space.$sid.focused left                     \
              --set space.$sid.focused                                  \
                              icon.drawing=off                         \
                              label.font="sketchybar-app-font:Regular:16.0" \
                              label.color=$BLACK                       \
                              label.padding_left=0                     \
                              label.padding_right=2                    \
                              label.y_offset=-1                        \
                              background.drawing=off                   \
                              background.padding_left=0                \
                              background.padding_right=0               \
                              drawing=off

  # Other app icons in this space (GREY = less prominent)
  sketchybar --add item    space.$sid.apps left                        \
              --set space.$sid.apps                                     \
                              icon.drawing=off                         \
                              label.font="sketchybar-app-font:Regular:16.0" \
                              label.color=$GREY                        \
                              label.padding_left=0                     \
                              label.padding_right=10                   \
                              label.y_offset=-1                        \
                              background.drawing=off                   \
                              background.padding_left=0                \
                              background.padding_right=0
done

sketchybar --set space.1 icon.padding_left=12

# Single pill covering all spaces
sketchybar --add bracket spaces                                        \
               space.1  space.1.focused  space.1.apps                 \
               space.2  space.2.focused  space.2.apps                 \
               space.3  space.3.focused  space.3.apps                 \
               space.4  space.4.focused  space.4.apps                 \
               space.5  space.5.focused  space.5.apps                 \
               space.6  space.6.focused  space.6.apps                 \
               space.7  space.7.focused  space.7.apps                 \
               space.8  space.8.focused  space.8.apps                 \
               space.9  space.9.focused  space.9.apps                 \
               space.10 space.10.focused space.10.apps                \
           --set spaces                                               \
                              background.color=0xffb8c0e0             \
                              background.height=26                     \
                              background.corner_radius=9               \
                              background.padding_left=-12              \
                              background.padding_right=-12

# Observer for focused app changes within the active space
sketchybar --add item    space.focus_observer left                     \
           --set space.focus_observer drawing=off updates=on           \
                                      script="$PLUGIN_DIR/space_front_app.sh" \
           --subscribe space.focus_observer front_app_switched

# Observer for window-list changes per space
sketchybar --add item    space.windows_observer left                   \
           --set space.windows_observer drawing=off updates=on         \
                                         script="$PLUGIN_DIR/space_windows.sh" \
           --subscribe space.windows_observer space_windows_change

sketchybar --add event   space_list_change                             \
           --add item    space.sync_observer left                      \
           --set space.sync_observer drawing=off updates=on            \
                                      script="$PLUGIN_DIR/space_sync.sh" \
           --subscribe space.sync_observer space_list_change

sketchybar --add item    separator left                                \
           --set separator icon=                                      \
                              width=0                                 \
                              icon.drawing=off                        \
                              icon.font="Hack Nerd Font:Regular:16.0" \
                              background.padding_left=0               \
                              background.padding_right=0              \
                              label.drawing=off                       \
                              icon.color=$WHITE

# ── Startup: populate labels from current yabai state ─────────────────────────
# Identical to a space_list_change refresh, so reuse that plugin rather than
# duplicating the per-space population logic here.
source "$PLUGIN_DIR/space_sync.sh"
