#!/bin/bash

if [ -f volEtot.dat ]; then
  rm volEtot.dat
fi

for a in 2.0 2.5 2.6 2.7 2.8 2.9 3.0 3.5 4.0
#for a in 2.0 2.5 2.6 2.7 2.72 2.74 2.76 2.78 2.8 2.9 3.0 3.5 4.0
do

cd Fe_$a/
vol=`grep "volume" OUTCAR | tail -1 | awk ' {printf "%12.3f \n", $5/2} '`
ET=` grep "energy  without entropy=" OUTCAR |awk '{printf  "%12.6f \n", $7/2}'`
echo "a=" $a
echo $a $vol $ET >> ../volEtot.dat

cd ../
done