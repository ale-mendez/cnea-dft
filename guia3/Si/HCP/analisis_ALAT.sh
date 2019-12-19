#!/bin/bash
#PBS -N Si_convergencia_ENCUT

if [ -f volEtot.dat ]; then
  rm volEtot.dat
fi

for a in 2.0 2.1 2.2 2.3 2.4 2.45 2.50 2.52 2.54 2.56 2.58 2.60 2.65 2.7 2.8 2.9 3.0
do

cd Si_$a/
vol=`grep "volume" OUTCAR | tail -1 | awk ' {printf "%12.3f \n", $5/2} '`
ET=` grep "energy  without entropy=" OUTCAR | tail -1 | awk '{printf  "%12.6f \n", $7/2}'`

echo $a $vol $ET >> ../volEtot.dat

cd ../
done
