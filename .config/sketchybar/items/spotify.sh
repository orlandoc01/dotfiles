#!/usr/bin/env sh

# sketchybar --add item spot_logo right \
#            --set spot_logo icon= \
#                            label.drawing=off \
#                            icon.color=0xff121219 \
#                            background.color=0xffEDC4E5


sketchybar --add item spot right \
           --set spot update_freq=1 \
                      label.font="$FONT:Semibold:10" \
                      icon.drawing=off \
                      updates=on \
                      script="$PLUGIN_DIR/spotify.sh" \
                      width=0                       \
                      y_offset=0                    \
                      background.padding_right=10   \
