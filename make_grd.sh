#!/bin/bash
root=/home/me/CAE/moving_barrier/
cd "$root"

grd="$root/grd/"
[ ! -d $grd ] && mkdir $grd

for f in $(ls m*.grd);
do
    ElmerGrid 1 2 $f >> /dev/null
    ElmerGrid 1 4 $f >> /dev/null
done
