#!/bin/bash
#PBS -N Si_convergencia_k
PBS -l nodes=1:ppn=4

cd $PBS_O_WORKDIR
#cat $PBS_NODEFILE > nodo.dat

module purge
module load vasp/5.4.1

#for a in 4.6 4.65 4.7 4.75 4.8 4.85 4.9 4.95 5.0 5.05 5.1 5.15 5.2   
for a in 3.8 4.1 4.4 5.4 5.7 6.0
do

mkdir Si_$a
cp KPOINTS POTCAR INCAR Si_$a/
cat > POSCAR <<!
beta Si
$a
1.0 0.0 0.0
0.0 1.0 0.0
0.5 0.5 0.26
2
Direct
-0.125 -0.375 0.25
 0.125 0.375 -0.25
!
echo "ALAT= $a"
cp POSCAR Si_$a/
cd Si_$a/

cat $PBS_NODEFILE > nodo.dat

mpirun -v -np 4 -machinefile nodo.dat /share/apps/vasp.5.4.1/bin/vasp_std > output



cd ../
done
