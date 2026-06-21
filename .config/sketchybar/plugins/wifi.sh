#!/usr/bin/env sh

# Wi-Fi popup data for macOS 26. The legacy `airport -I` binary was removed in
# macOS 14.4, so SSID and link rate now come from ipconfig / system_profiler.
WIFI_IF="${WIFI_IF:-en0}"

# SSID. macOS 14+ redacts this unless the calling process holds Location
# Services permission, so a "<redacted>"/empty value falls back to link state.
SSID=$(ipconfig getsummary "$WIFI_IF" 2>/dev/null | awk -F' SSID : ' '/ SSID : / {print $2; exit}')
case "$SSID" in
  ""|"<redacted>")
    if [ "$(ifconfig "$WIFI_IF" 2>/dev/null | awk '/status:/ {print $2}')" = "active" ]; then
      SSID="Connected"
    else
      SSID="Disconnected"
    fi
    ;;
esac

# Transmit rate in Mbps. system_profiler is the only non-root source on macOS
# 26; it is slow, but this only runs while the popup is open (updates=when_shown).
TX=$(system_profiler SPAirPortDataType 2>/dev/null | awk -F': ' '/Transmit Rate:/ {print $2; exit}')

sketchybar --set wifi.ssid  label="$SSID" \
           --set wifi.speed label="${TX:-—} Mbps"
