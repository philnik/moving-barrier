#!/bin/zsh
root=/home/me/CAE/moving_barrier/
cd "$root/sif/"
for f in $(ls *.sif);do
    ElmerSolver $f 
    rm $f
done
