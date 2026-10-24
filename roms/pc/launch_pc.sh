#!/bin/sh
LOG="/sdcard/pc_launch.log"
echo "=== PC Launch started at $(date) with ROM=$1 ===" > $LOG

ROM="$1"
GAME_DIR=$(dirname "$ROM")

# First-time automatic setup: recombine split homm2.iso if present
if [ ! -f "$GAME_DIR/homm2.iso" ] && [ -f "$GAME_DIR/homm2.iso.partaa" ]; then
    echo "First launch: Recombining homm2.iso from parts..." >> $LOG
    cat "$GAME_DIR"/homm2.iso.part* > "$GAME_DIR/homm2.iso"
    rm -f "$GAME_DIR"/homm2.iso.part*
fi

# Launch via RetroArch DOSBox SVN core
echo "Launching via RetroArch DOSBox SVN: $ROM" >> $LOG
exec /sdcard/minigui/retroarch -y 12 -c /sdcard/minigui/dosbox.cfg -L /storage/cores/dosbox_svn_libretro.so "$ROM"
