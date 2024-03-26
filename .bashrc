#!/bin/sh
function e () { emacsclient --alternate-editor="" --create-frame "${@}"; }
function montab () { swaymsg input "9580:109:GAOMON_Gaomon_Tablet_Pen" map_to_region 512 288 768 432; }
if [ ! -r $HOME/.w3m/history ]; then
  touch $HOME/.w3m/history
fi
export EDITOR="emacsclient --alternate-editor="" --create-frame"
function tubb () { wl-copy -n < $HOME/.config/tubpass.txt; }
function gm () { gammastep -O 4000 -b 0.7:0.7; }
