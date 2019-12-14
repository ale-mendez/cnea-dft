#!/bin/bash
#PBS -N Si_convergencia_ENCUT

if [ -f conkEtot.dat ]; then
   rm convkEtot.dat
fi
if [ -f volEtot.dat ]; then
   rm volEtot.dat
fi

for E in 240 270 300 330 360
do

cd Si_$E/

vol=`grep "volume" OUTCAR | tail -1 | awk ' {printf "%12.3f \n", $5/2} '`
ET=` grep "energy  without entropy=" OUTCAR |awk '{printf  "%12.6f \n", $7/2}'`
echo $E $ET >> ../convkEtot.dat
echo $vol $ET >> ../volEtot.dat

cd ../
done
