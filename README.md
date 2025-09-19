# 🔄 Waybar Screen Rotation

Smooth screen rotation script for Waybar + Hyprland with proper cursor boundary handling and touchscreen sync. Perfect for 2-in-1 laptops and tablet mode.

## ✨ Features

- 🔄 **Toggle rotation** between normal (0°) and flipped (180°)
- 🖱️ **Fixes cursor boundaries** after rotation (common Hyprland issue)
- 📱 **Automatic touchscreen mapping** to match screen orientation  
- 🎨 **Smooth transitions** with fade effects and notifications
- 🚀 **Zero configuration** - works out of the box
- ⚡ **Lightweight** - pure bash script using Hyprland APIs

## 🚀 Quick Setup

### 1. Install the Script

```bash
# Download and install
curl -o ~/.local/bin/waybar-rotate-screen https://raw.githubusercontent.com/scotty-007/waybar-rotate-screen/main/rotate-screen.sh
chmod +x ~/.local/bin/waybar-rotate-screen
```

### 2. Add to Waybar Config

Add this to your waybar `config` file:

```json
{
  "modules-left": [
    "hyprland/workspaces",
    "custom/rotate"
  ],

  "custom/rotate": {
    "format": "↻",
    "tooltip": "Rotate screen 180° (with style!)",
    "on-click": "waybar-rotate-screen"
  }
}
```

### 3. Restart Waybar

```bash
pkill waybar && waybar &
```

That's it! Click the button to rotate your screen.

## 🎯 Usage Examples

### Basic Waybar Module
```json
"custom/rotate": {
  "format": "↻",
  "tooltip": "Rotate screen",
  "on-click": "waybar-rotate-screen"
}
```

### With Custom Styling
```json
"custom/rotate": {
  "format": "{}",
  "return-type": "json",
  "exec": "echo '{\"text\":\"↻\", \"class\":\"rotate-button\"}'",
  "tooltip": "Rotate screen 180° (with style!)",
  "on-click": "waybar-rotate-screen"
}
```

### Alternative Icons
```json
"custom/rotate": {
  "format": "🔄",  // or "⟲" or "⮔" or "󰑒"
  "tooltip": "Flip screen",
  "on-click": "waybar-rotate-screen"
}
```

## ⚙️ Configuration

### Manual Installation
```bash
# Clone the repo
git clone https://github.com/scotty-007/waybar-rotate-screen.git
cd waybar-rotate-screen

# Copy to your PATH
cp rotate-screen.sh ~/.local/bin/waybar-rotate-screen
chmod +x ~/.local/bin/waybar-rotate-screen
```



## 🔧 Customization

### Keybinding (Optional)
Add to your Hyprland config:
```
bind = SUPER, F12, exec, waybar-rotate-screen
```

### Multiple Monitors
The script auto-detects your primary display (`eDP-1`). To customize:
```bash
# Edit the script and change:
MONITOR="eDP-1"  # Change to your display name
```

Find your display name with: `hyprctl monitors`

## 🧪 What It Does

1. **Detects current orientation** using Hyprland's monitor API
2. **Applies smooth fade effect** during transition
3. **Rotates display** between 0° and 180°
4. **Maps touchscreen** to match new orientation
5. **Fixes cursor boundaries** (resets hardware cursor constraints)
6. **Shows notifications** for user feedback
7. **Centers cursor** to prevent edge issues

## 🛠️ Requirements

- **Hyprland** (wlroots-based compositor)
- **Waybar**
- **notify-send** (libnotify) - for notifications
- **jq** - for JSON parsing

Most Hyprland setups already have these installed.

## 🤝 Contributing

Found a bug or want to improve something? PRs welcome!

## 📄 License

MIT License - use it however you want!

---

**Perfect for:** 2-in-1 laptops, convertible devices, tablet mode, presentation setups