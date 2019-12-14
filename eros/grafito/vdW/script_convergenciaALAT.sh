#!/bin/bash
PBS -l nodes=1:ppn=4

cd $PBS_O_WORKDIR

module purge
module load vasp/5.4.1

for a in 6.0 6.25 6.5 6.75 7.0 7.25 7.5  
do

mkdir grafito_$a
cp KPOINTS POTCAR INCAR grafito_$a/
cat > POSCAR <<!
system graphite
1.0
1.22800000 -2.12695839  0.00000000
1.22800000  2.12695839  0.00000000
0.00000000  0.00000000  $a 
C
4
direct
   0.00000000  0.00000000  0.25000000
   0.00000000  0.00000000  0.75000000
   0.33333333  0.66666667  0.25000000
   0.66666667  0.33333333  0.75000000
!
echo "ALAT= $a"
cp POSCAR grafito_$a/
cd grafito_$a/

cat $PBS_NODEFILE > nodo.dat

mpirun -v -np 4 -machinefile nodo.dat /share/apps/vasp.5.4.1/bin/vasp_std > output

cd ../
done
