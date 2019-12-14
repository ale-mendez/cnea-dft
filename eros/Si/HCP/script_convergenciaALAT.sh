#!/bin/bash
#PBS -N Si_convergencia_k
PBS -l nodes=1:ppn=4

cd $PBS_O_WORKDIR
#cat $PBS_NODEFILE > nodo.dat

module purge
module load vasp/5.4.1

for a in 2.0 2.1 2.2 2.3 2.4 2.45 2.50 2.52 2.54 2.56 2.58 2.60 2.65 2.7 2.8 2.9 3.0
do

mkdir Si_$a
cp KPOINTS POTCAR INCAR Si_$a/
cat > POSCAR <<!
Si HCP
$a
   1.00000         0.00000000000000      0.00000
  -0.50000         0.86602540378444      0.00000
   0.00000         0.00000000000000      1.63299
2
direct
   0.00000000000000    0.00000000000000      0.000000
   0.33333333333333    0.66666666666667      0.500000
!
echo "ALAT= $a"
cp POSCAR Si_$a/
cd Si_$a/

cat $PBS_NODEFILE > nodo.dat

mpirun -v -np 4 -machinefile nodo.dat /share/apps/vasp.5.4.1/bin/vasp_std > output



cd ../
done
