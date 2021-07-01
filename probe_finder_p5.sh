#!/bin/bash
#SBATCH --account=def-mcpherso
#SBATCH -c 1                      # Number of CPUS requested. If omitted, the default is 1 CPU.
#SBATCH --mem=10000M                  # Memory requested in megabytes. If omitted, the default is 1024 MB.
#SBATCH --time=2:59:00 # How long will your job run for? If omitted, the default is 3 hours.
#SBATCH -o /home/nikpay/projects/def-mcpherso/nikpay/mybulk/logs/aalog_%x-%j.out

c=$1

a=$2

smr_Linux --beqtl-summary ./besds/$c \
--extract-snp $a.snplist --query 5e-8 --out "$c"_"$a"_plist


sed '1d' "$c"_"$a"_plist.txt | awk '{print $7}' | sort -u | \
sed "s/^/$c /ig" >> "$a".besd.probes



rm "$c"_"$a"_plist.*




