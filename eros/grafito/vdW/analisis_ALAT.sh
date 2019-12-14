#!/bin/bash

if [ -f volEtot.dat ]; then
  rm volEtot.dat
fi

for a in 6.0 6.25 6.5 6.75 7.0 7.25 7.5
do

cd grafito_$a/
vol=`grep "volume" OUTCAR | tail -1 | awk ' {printf "%12.3f \n", $5/2} '`
ET=` grep "energy  without entropy=" OUTCAR |awk '{printf  "%12.6f \n", $7/2}'`
echo "ALAT=" $a
echo $a $vol $ET >> ../volEtot.dat

cd ../
done
