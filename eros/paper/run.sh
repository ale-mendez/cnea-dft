#!/bin/bash

cd $PBS_O_WORKDIR

module purge
module load vasp/5.4.1

cat $PBS_NODEFILE > nodo.dat

mpirun -v -np 4 -machinefile nodo.dat /share/apps/vasp.5.4.1/bin/vasp_std > output
