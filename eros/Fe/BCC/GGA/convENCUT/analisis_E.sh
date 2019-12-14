#!/bin/bash

if [ -f conkEtot.dat ]; then
   rm convkEtot.dat
fi
if [ -f volEtot.dat ]; then
   rm volEtot.dat
fi

for E in 300 350 400 450 500 
do

cd Fe_$E/

ET=` grep "energy  without entropy=" OUTCAR |awk '{printf  "%12.6f \n", $7/2}'`
echo $E $ET >> ../convkEtot.dat

cd ../
done
