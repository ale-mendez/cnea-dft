#!/bin/bash
PBS -l nodes=1:ppn=4

cd $PBS_O_WORKDIR

module purge
module load vasp/5.4.1

for a in 2.0 2.5 2.6 2.7 2.8 2.9 3.0 3.5 4.0 
#for a in 2.6 2.7 2.8 2.9 
#for a in 2.72 2.74 2.76 2.78
do

mkdir Fe_$a
cp KPOINTS POTCAR INCAR Fe_$a/
cat > POSCAR <<!
Fe BCC
$a
-0.5  0.5  0.5
 0.5 -0.5  0.5
 0.5  0.5 -0.5
Fe
1
Direct
0.000000000000 0.000000000000000 0.000000000000

!
echo "ALAT= $a"
cp POSCAR Fe_$a/
cd Fe_$a/

cat $PBS_NODEFILE > nodo.dat

mpirun -v -np 4 -machinefile nodo.dat /share/apps/vasp.5.4.1/bin/vasp_std > output

cd ../
done
