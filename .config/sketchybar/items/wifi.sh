#!/usr/bin/env sh

# SSID and link rate are filled in by plugins/wifi.sh when the popup is opened.
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar --add item           wifi.control right                      \
                                                                        \
           --set wifi.control   icon=$WIFI_ICN                          \
                                label.drawing=off                       \
                                click_script="$POPUP_CLICK_SCRIPT"      \
                                popup.background.color=0x70000000       \
                                popup.blur_radius=50                    \
                                popup.background.corner_radius=5        \
                                                                        \
           --add item           wifi.ssid popup.wifi.control            \
           --set wifi.ssid      icon=$NETWORK_ICN                       \
                                label="Wi-Fi"                           \
                                                                        \
           --add item           wifi.speed     popup.wifi.control       \
           --set wifi.speed     icon=$SPEED_ICN                         \
                                script="$PLUGIN_DIR/wifi.sh"            \
                                update_freq=10                          \
