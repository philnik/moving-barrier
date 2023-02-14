#!/bin/bash
root=/home/me/CAE/moving_barrier/
cd "$root"

[ ! -d "$root/sif" ] &&  mkdir $root/sif/

grd="$root/grd/"
[ ! -d $grd ] && mkdir $grd

for f in $(ls m*.grd);
do
    ElmerGrid 1 2 $f >> /dev/null
    ElmerGrid 1 4 $f >> /dev/null
done

for f in m[0-9]*.grd;do cp -r ${f%.grd} ./sif/;done
