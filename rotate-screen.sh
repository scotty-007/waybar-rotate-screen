#!/bin/bash
# Enhanced rotation script with improved cursor boundary handling
MONITOR="eDP-1"
TOUCHSCREEN="elan9024:00-04f3:4297"
CURRENT_TRANSFORM=$(hyprctl monitors -j | jq -r '.[0].transform')

# Show notification
notify-send "🔄 Rotating Display" "Flipping screen and touchscreen..." -t 1000

# Brief fade effect
hyprctl keyword decoration:dim_inactive true
hyprctl keyword decoration:dim_strength 0.3
sleep 0.2

if [ "$CURRENT_TRANSFORM" = "0" ]; then
    # Rotate to 180 degrees
    hyprctl keyword monitor "eDP-1,2560x1600@165,0x0,1,transform,2"
    hyprctl keyword input:touchdevice:transform 2
    echo "Rotated display and touchscreen to 180°"
else
    # Rotate back to normal
    hyprctl keyword monitor "eDP-1,2560x1600@165,0x0,1,transform,0"
    hyprctl keyword input:touchdevice:transform 0
    echo "Rotated display and touchscreen back to normal"
fi

# Wait for monitor config to apply
sleep 0.5

# Reset cursor boundaries without reloading entire config
# Method 1: Toggle hardware cursors to force boundary recalculation

# Method 1: Ensure software cursors stay enabled for transform compatibility
hyprctl keyword cursor:no_hardware_cursors true
hyprctl keyword cursor:use_cpu_buffer true
sleep 0.1

# Method 2: Move cursor to force boundary refresh
MONITOR_INFO=$(hyprctl monitors -j | jq -r '.[0] | "\(.width) \(.height)"')
WIDTH=$(echo $MONITOR_INFO | cut -d' ' -f1)
HEIGHT=$(echo $MONITOR_INFO | cut -d' ' -f2)
CENTER_X=$((WIDTH / 2))
CENTER_Y=$((HEIGHT / 2))

# Warp cursor to center to reset boundaries
hyprctl dispatch movecursor $CENTER_X $CENTER_Y

# Additional cursor constraint reset
hyprctl dispatch movecursor 0 0
hyprctl dispatch movecursor $CENTER_X $CENTER_Y

sleep 0.3

# Restore normal dimming
hyprctl keyword decoration:dim_inactive false

# Success notification
notify-send "✅ Rotation Complete" "Display and touchscreen synced!" -t 1000
