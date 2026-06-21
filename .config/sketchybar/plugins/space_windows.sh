#!/usr/bin/env sh

case "$SENDER" in
  "space_change")
    if [ "$SELECTED" = "true" ]; then
      sketchybar --set "$NAME" icon.highlight=on label.highlight=on
    else
      sketchybar --set "$NAME" icon.highlight=off label.highlight=off
    fi
    ;;
  "space_windows_change")
    SPACE=$(echo "$INFO" | jq -r '.space')
    [ "$SPACE" = "$SID" ] || exit 0

    source "$HOME/.config/sketchybar/icon_map.sh"
    ICON_LINE=""
    while IFS= read -r app; do
      [ -n "$app" ] || continue
      __icon_map "$app"
      ICON_LINE="$ICON_LINE$icon_result"
    done <<APPS
$(echo "$INFO" | jq -r '.apps | keys[]')
APPS

    [ -n "$ICON_LINE" ] || ICON_LINE=" —"
    sketchybar --set "$NAME" label="$ICON_LINE"
    ;;
esac
