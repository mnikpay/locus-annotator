#!/bin/bash
#SBATCH --account=def-mcpherso
#SBATCH -c 1                      # Number of CPUS requested. If omitted, the default is 1 CPU.
#SBATCH --mem=10000M                  # Memory requested in megabytes. If omitted, the default is 1024 MB.
#SBATCH --time=2:59:00 # How long will your job run for? If omitted, the default is 3 hours.
#SBATCH -o /home/nikpay/projects/def-mcpherso/nikpay/mybulk/logs/aalog_%x-%j.out


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



