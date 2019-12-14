#!/bin/bash
#PBS -N Si_convergencia_ENCUT

if [ -f volEtot.dat ]; then
  rm volEtot.dat
fi

for a in 4.4 4.6 4.8 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 6.0 6.2 6.4 6.6
do

cd Si_$a/
vol=`grep "volume" OUTCAR | tail -1 | awk ' {printf "%12.3f \n", $5/2} '`
ET=` grep "energy  without entropy=" OUTCAR |awk '{printf  "%12.6f \n", $7/2}'`

echo $a $vol $ET >> ../volEtot.dat

cd ../
done
