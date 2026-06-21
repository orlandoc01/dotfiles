#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"

ME=$(whoami)
CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)

# Single walk of the process table; derived metrics are read from this snapshot.
CPU_INFO=$(ps axco pcpu=,user=,comm=)
CPU_SYS=$(echo "$CPU_INFO" | awk -v me="$ME" -v c="$CORE_COUNT" '$2!=me {sum+=$1} END {print sum/(100.0*c)}')
CPU_USER=$(echo "$CPU_INFO" | awk -v me="$ME" -v c="$CORE_COUNT" '$2==me {sum+=$1} END {print sum/(100.0*c)}')
TOPPROC=$(echo "$CPU_INFO" | sort -nr | head -n1 | awk '{c=$3; for (i=4;i<=NF;i++) c=c" "$i; sub(/com\.apple\./,"",c); printf "%.0f%% %s", $1, c}')

CPU_PERCENT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"

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
