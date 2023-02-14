#!/bin/zsh
root=/home/me/CAE/moving_barrier/
cd "$root/sif/"
for i j k l
 in $(ls *.sif);
do
    echo $i:$j
    ElmerSolver $i &
    ElmerSolver $j &
    ElmerSolver $k &
    ElmerSolver $l  
    rm $i 
    rm $j
    rm $k
    rm $l
    echo "*****"
done
