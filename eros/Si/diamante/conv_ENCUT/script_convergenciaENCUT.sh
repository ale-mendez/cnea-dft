#!/bin/bash
#PBS -N Si_convergencia_k
PBS -l nodes=1:ppn=4

cd $PBS_O_WORKDIR
#cat $PBS_NODEFILE > nodo.dat

module purge
module load vasp/5.4.1


for E in 240 270 300 330 360 
do

mkdir Si_$E
cp KPOINTS POTCAR POSCAR  Si_$E/
cat > INCAR <<!
System = Si diamante
ISMEAR = 0; SIGMA = 0.1;
ENMAX = $E 
IBRION=-1;
EDIFF = 0.1E-04
PREC=accurate
!
echo "ENCUT= $E"
cp INCAR Si_$E/
cd Si_$E/

cat $PBS_NODEFILE > nodo.dat

mpirun -v -np 4 -machinefile nodo.dat /share/apps/vasp.5.4.1/bin/vasp_std > output



cd ../
done
