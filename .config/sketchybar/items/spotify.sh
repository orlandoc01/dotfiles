#!/usr/bin/env sh

# sketchybar --add item spot_logo right \
#            --set spot_logo icon= \
#                            label.drawing=off \
#                            icon.color=0xff121219 \
#                            background.color=0xffEDC4E5


sketchybar --add item spot left \
           --set spot update_freq=10 \
                      updates=on \
                      label.font="$FONT:Semibold:13.0" \
                      icon.drawing=off \
                      script="$PLUGIN_DIR/spotify.sh" \
                      drawing=off                   \
                      y_offset=0                    \
                      background.padding_left=10
