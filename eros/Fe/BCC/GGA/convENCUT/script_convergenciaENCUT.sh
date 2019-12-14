#!/bin/bash
PBS -l nodes=1:ppn=4

cd $PBS_O_WORKDIR

module purge
module load vasp/5.4.1

for E in 300 350 400 450 500  
do

mkdir Fe_$E
cp KPOINTS POTCAR POSCAR Fe_$E/
cat > INCAR <<!
System = Fe BCC 
PREC = Accurate
ENMAX = $E
EDIFF =1E-6
ISMEAR = -5
ISPIN = 2 ! spin polarized calculation (ferro - magnetic )
MAGMOM = 4   ! initial magnetic moments (anti - ferromagnetic ordering )
LORBIT = 11
!
echo "ENCUT= $E"
cp INCAR Fe_$E/
cd Fe_$E/

cat $PBS_NODEFILE > nodo.dat

mpirun -v -np 4 -machinefile nodo.dat /share/apps/vasp.5.4.1/bin/vasp_std > output



cd ../
done
