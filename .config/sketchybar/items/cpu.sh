#!/usr/bin/env sh

# Clicking anywhere on the CPU cluster opens Activity Monitor.
CPU_CLICK="open -a 'Activity Monitor'"

sketchybar --add item        cpu.top right                 \
           --set cpu.top     label.font="$FONT:Semibold:7" \
                             label=CPU                     \
                             icon.drawing=off              \
                             width=0                       \
                             y_offset=6                    \
                             background.padding_right=10   \
                             click_script="$CPU_CLICK"     \
                                                           \
           --add item        cpu.percent right             \
           --set cpu.percent label.font="$FONT:Heavy:12"   \
                             label=CPU                     \
                             y_offset=-4                   \
                             width=40                      \
                             icon.drawing=off              \
                             background.padding_right=10   \
                             click_script="$CPU_CLICK"     \
                                                           \
           --add graph       cpu.sys right 100             \
           --set cpu.sys     width=0                       \
                             graph.color=$RED              \
                             graph.fill_color=$RED         \
                             label.drawing=off             \
                             icon.drawing=off              \
                             background.padding_right=10   \
                             background.padding_left=10    \
                             background.height=30          \
                             background.drawing=on         \
                             background.color=$TRANSPARENT \
                             click_script="$CPU_CLICK"     \
                                                           \
           --add graph       cpu.user right 100            \
           --set cpu.user    graph.color=$BLUE             \
                             update_freq=10                \
                             label.drawing=off             \
                             icon.drawing=off              \
                             background.padding_right=10   \
                             background.padding_left=10    \
                             background.height=30          \
                             background.drawing=on         \
                             background.color=$TRANSPARENT \
                             click_script="$CPU_CLICK"     \
                             script="$PLUGIN_DIR/cpu.sh"
