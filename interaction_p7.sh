#!/bin/bash

a=$1

cat $a.besd.probes | awk '{print $1"__"$2}' > $a.besd.probes.txt

for i in $(cat $a.besd.probes.txt)

do
        for j in $(cat $a.besd.probes.txt)

do
	if [ $i \> $j ]

	then
 
echo "Pair $i and $j"

echo $i $j >> $a.pairs.txt

fi

done

done

cat $a.pairs.txt | sed 's/__/ /ig' > $a.pairs


while read line; do echo $line;bash pairwise_probes_p8.sh $line $a; done < $a.pairs

