#!/bin/bash

# Run this script as a cron job. Randomizes wallpapers from the .png files
# listed in ~/.wallpaper. With multiple xrandr screens, chooses a different
# file for each screen.

# Example usage:
#   # cd /etc/cron.hourly
#   # ln -s /home/llama/.wallpaper/randomize.sh randomize-wallpaper

DISPLAY=:0 feh --randomize --bg-fill /home/llama/.wallpaper/*.png
