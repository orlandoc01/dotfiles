#!/usr/bin/env sh

PLUGIN_DIR="${PLUGIN_DIR:-$HOME/.config/sketchybar/plugins}"
source "$HOME/.config/sketchybar/colors.sh"

POPUP_CLOSE="sketchybar -m --set media_ctrl.anchor popup.drawing=toggle"

# The display is driven by plugins/media_stream.sh (event-based); the anchor
# only needs a script to handle popup hover/click, so it does not poll.
media_ctrl_anchor=(
  script="$PLUGIN_DIR/media_ctrl.sh"
  click_script="$POPUP_CLOSE"
  icon.drawing=off
  padding_left=0
  label.padding_left=0
  popup.horizontal=on
  popup.align=center
  popup.height=150
)

media_ctrl_cover=(
  script="$PLUGIN_DIR/media_ctrl.sh"
  click_script="$POPUP_CLOSE"
  label.drawing=off
  icon.drawing=off
  padding_left=12
  padding_right=10
  background.image.scale=0.6
  background.image.drawing=on
  background.drawing=on
)

media_ctrl_title=(
  icon.drawing=off
  padding_left=0
  padding_right=0
  width=0
  label.font="$FONT:Heavy:15.0"
  label.max_chars=25
  y_offset=55
)

media_ctrl_artist=(
  icon.drawing=off
  y_offset=30
  padding_left=0
  padding_right=0
  width=0
  label.max_chars=20
)

media_ctrl_album=(
  icon.drawing=off
  padding_left=0
  padding_right=0
  y_offset=15
  width=0
  label.max_chars=30
)

media_ctrl_back=(
  icon=􀊎
  icon.padding_left=5
  icon.padding_right=5
  icon.color=$WHITE
  script="$PLUGIN_DIR/media_ctrl.sh"
  label.drawing=off
  y_offset=-45
)

media_ctrl_play=(
  icon=􀊆
  background.height=40
  background.corner_radius=20
  width=100
  align=center
  background.color=$POPUP_BACKGROUND_COLOR
  background.border_color=$WHITE
  background.border_width=0
  background.drawing=on
  icon.padding_left=4
  icon.padding_right=5
  updates=on
  label.drawing=off
  script="$PLUGIN_DIR/media_ctrl.sh"
  y_offset=-45
)

media_ctrl_next=(
  icon=􀊐
  icon.padding_left=5
  icon.padding_right=5
  icon.color=$WHITE
  script="$PLUGIN_DIR/media_ctrl.sh"
  label.drawing=off
  y_offset=-45
)

media_ctrl_controls=(
  background.color=$GREEN
  background.corner_radius=11
  background.drawing=on
  y_offset=-45
)

media_ctrl_app_icon=(
  drawing=off
  label.font="sketchybar-app-font:Regular:16.0"
  label.color=$WHITE
  label.y_offset=-1
  label.padding_left=0
  label.padding_right=4
  icon.drawing=off
  background.drawing=off
  padding_left=0
  padding_right=0
)

sketchybar --add item   media_ctrl.app_icon left                               \
           --set        media_ctrl.app_icon "${media_ctrl_app_icon[@]}"        \
                                                                               \
           --add item   media_ctrl.anchor  left                                \
           --set        media_ctrl.anchor  "${media_ctrl_anchor[@]}"           \
                                                                               \
           --add item   media_ctrl.cover   popup.media_ctrl.anchor             \
           --set        media_ctrl.cover   "${media_ctrl_cover[@]}"            \
                                                                               \
           --add item   media_ctrl.title   popup.media_ctrl.anchor             \
           --set        media_ctrl.title   "${media_ctrl_title[@]}"            \
                                                                               \
           --add item   media_ctrl.artist  popup.media_ctrl.anchor             \
           --set        media_ctrl.artist  "${media_ctrl_artist[@]}"           \
                                                                               \
           --add item   media_ctrl.album   popup.media_ctrl.anchor             \
           --set        media_ctrl.album   "${media_ctrl_album[@]}"            \
                                                                               \
           --add item   media_ctrl.back    popup.media_ctrl.anchor             \
           --set        media_ctrl.back    "${media_ctrl_back[@]}"             \
           --subscribe  media_ctrl.back    mouse.clicked                       \
                                                                               \
           --add item   media_ctrl.play    popup.media_ctrl.anchor             \
           --set        media_ctrl.play    "${media_ctrl_play[@]}"             \
           --subscribe  media_ctrl.play    mouse.clicked                       \
                                                                               \
           --add item   media_ctrl.next    popup.media_ctrl.anchor             \
           --set        media_ctrl.next    "${media_ctrl_next[@]}"             \
           --subscribe  media_ctrl.next    mouse.clicked                       \
                                                                               \
           --add item   media_ctrl.spacer  popup.media_ctrl.anchor             \
           --set        media_ctrl.spacer  width=5                             \
                                                                               \
           --add bracket media_ctrl.controls media_ctrl.back                   \
                                             media_ctrl.play                   \
                                             media_ctrl.next                   \
           --set        media_ctrl.controls "${media_ctrl_controls[@]}"
