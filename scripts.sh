******************************************************
#! /bin/bash
#Comento algo
variable='hola mundo!'
echo $variable
*******************************************************
#! /bin/bash
#Comento algo
for i in 3.1 3.2 3.3
do 
mkdir caso-$i
done
********************************************************
#! /bin/bash
#Comento algo
for i in 3.1 3.2 3.3
do 
mkdir caso-$i
cd caso-$i
touch 'Hola'
cd ..
done
*******************************************************
#! /bin/bash
#Comento algo
for i in  3.2 3.3 3.4 
do
awk -v a=$i '{ if (NR==2) $1=a; print $0}' POSCAR > POSCAR_$i
done
*********************************************************
#! /bin/bash
#Comento algo
for i in 3.1 3.2 3.3
do
awk -v a=$i '{ if (NR==2) $1=a; print $0}' POSCAR > POSCAR_$i	
mkdir caso-$i
cp POSCAR_$i caso-$i
done
