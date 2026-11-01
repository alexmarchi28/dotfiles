#!/bin/bash
# Modulo Waybar custom/brightness: luminosità del monitor via DDC/CI (monictrl), in JSON
v=$(~/.local/bin/monictrl 10)
if [[ ! $v =~ ^[0-9]+$ ]]; then
  printf '{"text":"%s","tooltip":"Monitor non raggiungibile via DDC/CI","class":"error"}\n' $'\U000F00DE'
  exit 0
fi
if (( v < 34 )); then icon=$'\U000F00DE'; elif (( v < 67 )); then icon=$'\U000F00DF'; else icon=$'\U000F00E0'; fi
printf '{"text":"%s","tooltip":"Luminosità %s%%","percentage":%s}\n' "$icon" "$v" "$v"
