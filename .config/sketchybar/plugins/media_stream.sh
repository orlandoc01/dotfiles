#!/usr/bin/env bash
#
# Event-driven now-playing source for the media_ctrl widget.
#
# Launched once from sketchybarrc and kept alive in the background. It consumes
# `media-control stream` (ungive/media-control, which restores now-playing on
# macOS 15.4+ via the mediaremote-adapter) and pushes updates to sketchybar only
# when playback actually changes. This replaces the old 10s poll that spawned
# five nowplaying-cli processes plus a pgrep loop on every single cycle.

MC=/opt/homebrew/bin/media-control
source "$HOME/.config/sketchybar/icon_map.sh"

LAST_TITLE=""

# `media-control stream` runs as a perl adapter child of this shell. Reap it (and
# any in-flight `media-control get`) when sketchybar terminates this script on
# --reload, instead of leaving an orphan around until its pipe closes.
cleanup() { pkill -P $$ 2>/dev/null; }
trap 'cleanup; exit 0' INT TERM
trap cleanup EXIT

# Map a media app's bundle identifier to the display name icon_map expects.
bundle_to_app() {
  case "$1" in
    com.spotify.client)         echo "Spotify" ;;
    com.apple.Music)            echo "Music" ;;
    com.apple.podcasts)         echo "Podcasts" ;;
    com.apple.TV)               echo "TV" ;;
    com.apple.QuickTimePlayerX) echo "QuickTime Player" ;;
    com.apple.Safari*)          echo "Safari" ;;
    com.google.Chrome*)         echo "Google Chrome" ;;
    company.thebrowser.Browser) echo "Arc" ;;
    org.mozilla.firefox*)       echo "Firefox" ;;
    com.brave.Browser*)         echo "Brave Browser" ;;
    *)                          echo "" ;;
  esac
}

hide() {
  sketchybar -m --set media_ctrl.anchor   drawing=off \
                --set media_ctrl.app_icon  drawing=off
}

render() {
  local line="$1" title artist album bundle playing play_icon

  # Single jq pass extracts every field we need. `playing` is the play-state
  # boolean; older media-control versions only expose `playbackRate`.
  IFS=$'\t' read -r title artist album bundle playing <<TSV
$(jq -r '[.payload.title, .payload.artist, .payload.album, .payload.bundleIdentifier,
          (if   .payload.playing      != null then (.payload.playing|tostring)
           elif .payload.playbackRate != null then ((.payload.playbackRate > 0)|tostring)
           else "" end)] | @tsv' <<<"$line" 2>/dev/null)
TSV

  if [ -z "$title" ]; then
    hide
    LAST_TITLE=""
    return
  fi

  play_icon=􀊆
  [ "$playing" = "false" ] && play_icon=􀊄

  # App icon (sketchybar-app-font glyph) from the playing app's bundle id.
  __icon_map "$(bundle_to_app "$bundle")"
  if [ -n "$icon_result" ] && [ "$icon_result" != ":default:" ]; then
    sketchybar --set media_ctrl.app_icon label="$icon_result" drawing=on
  else
    sketchybar --set media_ctrl.app_icon drawing=off
  fi

  # Cover art only changes when the track does, so fetch it (with artwork) just
  # then instead of decoding base64 on every event.
  if [ "$title" != "$LAST_TITLE" ]; then
    "$MC" get | jq -r '.artworkData // empty' | base64 --decode > /tmp/cover.jpg 2>/dev/null
    [ -s /tmp/cover.jpg ] && \
      sketchybar --set media_ctrl.cover background.image=/tmp/cover.jpg background.color=0x00000000
    LAST_TITLE="$title"
  fi

  if [ -z "$artist" ]; then
    sketchybar -m \
      --set media_ctrl.title  label="$title" \
      --set media_ctrl.album  label="Podcast" \
      --set media_ctrl.artist label="$album" \
      --set media_ctrl.play   icon="$play_icon" \
      --set media_ctrl.anchor label="$title" drawing=on
  else
    sketchybar -m \
      --set media_ctrl.title  label="$title" \
      --set media_ctrl.album  label="$album" \
      --set media_ctrl.artist label="$artist" \
      --set media_ctrl.play   icon="$play_icon" \
      --set media_ctrl.anchor label="$title - $artist" drawing=on
  fi
}

# Reconnect if the stream ever exits (system sleep/wake, adapter crash) so the
# widget never silently goes stale until the next reload. Process substitution
# keeps the read loop in this shell, so `playing`/title state persists across
# events and the perl producer stays a direct child under the cleanup trap.
# --no-diff makes each event a complete snapshot; --no-artwork keeps events tiny
# (artwork is fetched per track change above).
while true; do
  while IFS= read -r line; do
    [ -n "$line" ] && render "$line"
  done < <("$MC" stream --no-diff --no-artwork)
  sleep 1
done
