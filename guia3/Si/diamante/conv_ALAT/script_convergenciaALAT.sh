#!/bin/bash
#PBS -N Si_convergencia_k
PBS -l nodes=1:ppn=4

cd $PBS_O_WORKDIR
#cat $PBS_NODEFILE > nodo.dat

module purge
module load vasp/5.4.1


#for a in 4.4 4.6 4.8 5.0 5.2 5.4 5.6 5.8 6.0 6.2 6.4 6.6
for a in 5.1 5.3 5.5 5.7 
do

mkdir Si_$a
cp KPOINTS POTCAR INCAR Si_$a/
cat > POSCAR <<!
diamond Si
$a
0.0 0.5 0.5
0.5 0.0 0.5
0.5 0.5 0.0
2
Cartesian
0.0  0.0  0.0
0.25 0.25 0.25
!
echo "ALAT= $a"
cp POSCAR Si_$a/
cd Si_$a/

cat $PBS_NODEFILE > nodo.dat

mpirun -v -np 4 -machinefile nodo.dat /share/apps/vasp.5.4.1/bin/vasp_std > output



cd ../
done
