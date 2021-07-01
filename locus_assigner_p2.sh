#!/bin/bash

locus=$1

a=$(echo $locus | sed 's/chr//' | sed 's/\:/__/' | sed 's/\-/__/')


if [[ $locus == chr+([0-9])\:+([0-9]) ]]

then

  echo "The variable is Position."

echo $locus | sed 's/chr//' | awk -F":" '{print $1,$2-1000,$2+1000}' | \
awk '{if ($2 < 0) print $1,0,$3; else print $0}' | sed "s/$/ $a/" > $a



elif [[ $locus == chr+([0-9])\:+([0-9])\-+([0-9]) ]]
then

  echo "The variable is Range."

echo $locus | sed 's/chr//' | sed 's/\-/\:/' | awk -F":" '{print $1,$2-1000,$3+1000}' | \
awk '{if ($2 < 0) print $1,0,$3; else print $0}' | sed "s/$/ $a/" > $a


else
  echo "The variable is undefined."
fi



