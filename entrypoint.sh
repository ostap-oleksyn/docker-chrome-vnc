#! /bin/sh

Xvfb "$DISPLAY" -ac -listen tcp -screen 0 "$RESOLUTION" &
sleep 3
/usr/bin/fluxbox -display "$DISPLAY" -screen 0 &
sleep 3
x11vnc -display "$DISPLAY" -forever