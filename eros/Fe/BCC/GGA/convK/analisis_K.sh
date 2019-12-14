#!/bin/bash

if [ -f conkEtot.dat ]; then
   rm convkEtot.dat
fi
if [ -f volEtot.dat ]; then
   rm volEtot.dat
fi

for k in 4 6 8 10 12 
do

echo "k= $k"
cd Fe_$k/

ET=` grep "energy  without entropy=" OUTCAR |awk '{printf  "%12.6f \n", $7/2}'`
echo $k $ET >> ../convkEtot.dat
 
cd ../
done
