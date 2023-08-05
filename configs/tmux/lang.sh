#!/bin/bash
# Returning current MacOS language

lang=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID | awk -F. '{print $4}' | cut -c1-3)
echo "${lang^^}"
