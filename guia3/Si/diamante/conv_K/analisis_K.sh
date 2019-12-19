#!/bin/bash
#PBS -N Si_convergencia_k

if [ -f conkEtot.dat ]; then
   rm convkEtot.dat
fi
if [ -f volEtot.dat ]; then
   rm volEtot.dat
fi

for k in 2 4 6 8 
do

echo "k= $k"
cd Si_$k/

vol=`grep "volume" OUTCAR | tail -1 | awk ' {printf "%12.3f \n", $5/2} '`
E=`grep "TOTEN" OUTCAR | tail -1 | awk '{printf "%12.6f \n", $5 }'`
ET=` grep "energy  without entropy=" OUTCAR |awk '{printf  "%12.6f \n", $7/2}'`
echo $k $ET >> ../convkEtot.dat
echo $vol $ET >> ../volEtot.dat
 
cd ../
done
