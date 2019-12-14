#!/bin/bash
PBS -l nodes=1:ppn=4

cd $PBS_O_WORKDIR

module purge
module load vasp/5.4.1

for k in 4 6 8 10 12 
do

mkdir Fe_$k
cp INCAR POTCAR POSCAR  Fe_$k/
cat > KPOINTS <<!
K-Points
0
Monkhorst-Pack
  $k  $k  $k
 0  0  0
!
echo "k= $k"
cp KPOINTS Fe_$k
cd Fe_$k/

cat $PBS_NODEFILE > nodo.dat

mpirun -v -np 4 -machinefile nodo.dat /share/apps/vasp.5.4.1/bin/vasp_std > output

cd ../
done
