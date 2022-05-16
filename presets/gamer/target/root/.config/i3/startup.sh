#!/bin/bash

xrandr --listmonitors | grep -q DP-0 && xrandr --output DP-0 --primary && xrandr --output DP-0 --mode 1920x1080 --rate 144.00
