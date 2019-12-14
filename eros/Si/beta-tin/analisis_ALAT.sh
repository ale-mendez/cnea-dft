#!/bin/bash
#PBS -N Si_convergencia_ENCUT

if [ -f volEtot.dat ]; then
  rm volEtot.dat
fi

for a in  3.8 4.1 4.4 4.6 4.65 4.7 4.75 4.8 4.85 4.9 4.95 5.0 5.05 5.1 5.15 5.2 5.4 5.7 6.0
do

cd Si_$a/
vol=`grep "volume" OUTCAR | tail -1 | awk ' {printf "%12.3f \n", $5/2} '`
ET=` grep "energy  without entropy=" OUTCAR | tail -1 | awk '{printf  "%12.6f \n", $7/2}'`

echo $a $vol $ET >> ../volEtot.dat

cd ../
done
