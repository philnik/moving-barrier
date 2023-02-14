#!/bin/bash
root=/home/me/CAE/moving_barrier/
cd "$root/sif/resu/"

for f in $(ls *.vtu);do
	 out=$(echo $f | sed -e 's/_t0001.vtu/\.vtu/g')
	 mv $f  ./delme/$out
done
