#!/bin/bash
#PBS -N Si_convergencia_k
PBS -l nodes=1:ppn=4

cd $PBS_O_WORKDIR
#cat $PBS_NODEFILE > nodo.dat


module purge
module load vasp/5.4.1

for k in 2 4 6 8 
do

mkdir Si_$k
cp INCAR POTCAR POSCAR  Si_$k/
cat > KPOINTS <<!
K-Points
0
Monkhorst-Pack
  $k  $k  $k
 0  0  0
!
echo "k= $k"
cp KPOINTS Si_$k
cd Si_$k/

cat $PBS_NODEFILE > nodo.dat

mpirun -v -np 4 -machinefile nodo.dat /share/apps/vasp.5.4.1/bin/vasp_std > output


cd ../
done
