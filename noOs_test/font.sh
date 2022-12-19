#!/bin/bash

HEIGHT=13
WIDTH=7

cat /dev/null > font.h
echo "const char font_map[128][$HEIGHT] = {" > font.h

for i in {0..127}
do
    PREFIX=$(convert -resize ${WIDTH}x${HEIGHT}\! -font JetBrains-Mono-Medium -pointsize 10 label:\x$(printf %x $i) xbm: | grep -zoP '\{[\s0-9x,A-F]+\}' | tr '\n' ' ')
    echo "${PREFIX}," >> font.h
done

echo "};" >> font.h
