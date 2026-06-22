#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"

ME=$(whoami)
CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)

# Single walk of the process table, and a single awk pass that derives every
# metric (system/user load, total percent, and the busiest process) at once.
IFS=' ' read -r CPU_SYS CPU_USER CPU_PERCENT TOPPROC <<EOF
$(ps axco pcpu=,user=,comm= | awk -v me="$ME" -v c="$CORE_COUNT" '
  {
    if ($2 == me) user += $1; else sys += $1
    if ($1 + 0 > maxp) {
      maxp = $1 + 0
      cmd = $3; for (i = 4; i <= NF; i++) cmd = cmd " " $i
      topp = $1
    }
  }
  END {
    sub(/com\.apple\./, "", cmd)
    printf "%.4f %.4f %.0f %.0f%% %s", sys/(100.0*c), user/(100.0*c), (sys+user)/c, topp, cmd
  }')
EOF

COLOR=$WHITE
case "$CPU_PERCENT" in
  [1-2][0-9]) COLOR=$YELLOW
  ;;
  [3-6][0-9]) COLOR=$ORANGE
  ;;
  [7-9][0-9]|100) COLOR=$RED
  ;;
esac

sketchybar --set  cpu.percent label=$CPU_PERCENT% \
                              label.color=$COLOR  \
           --set  cpu.top     label="$TOPPROC"    \
           --push cpu.sys     $CPU_SYS            \
           --push cpu.user    $CPU_USER
