#!/bin/bash

if [ -f volEtot.dat ]; then
  rm volEtot.dat
fi

for a in 6.0 6.5 7.0 7.5 8.0 8.5 9.0 9.5
do

cd grafito_$a/
vol=`grep "volume" OUTCAR | tail -1 | awk ' {printf "%12.3f \n", $5/2} '`
ET=` grep "energy  without entropy=" OUTCAR |awk '{printf  "%12.6f \n", $7/2}'`
echo "ALAT=" $a
echo $a $vol $ET >> ../volEtot.dat

cd ../
done
