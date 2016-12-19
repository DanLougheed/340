#!/bin/bash
echo "========================="

echo "The day is :"$(date +%d) 
echo "The month is: "$(date +%b) 
Day=$(date +%d) 
Month=$(date +%b)
echo "========================="

echo "Parameters"
echo 'Log File:  ' $1
echo 'Number of Days:  ' $2

grep -e Error -e error -e ER -e ERROR -e Shutdown -e shutdown $1 > /tmp/checktmp.txt
Count=$(expr $Day - $2)
while [ $Count -le $Day ]; do
grep "$Month $Count" /tmp/checktmp.txt >> /tmp/Logcheck.txt 

((Count++))

done

check=$3
if [ $check -eq 1 ]
then
mover=$(expr 7 + $2)
daycheck=$(expr $Day - $mover)
while [ $daycheck -le $Day ]; do
echo "********************************************" >> /tmp/LockFinal.txt
echo "*                 $daycheck                *" >> /tmp/LockFinal.txt
echo "********************************************" >> /tmp/LockFinal.txt
grep "$Month $daycheck" /tmp/Logcheck.txt >>  /var/log/LockFinal.txt
((daycheck++))
done
cat /tmp/LockFinal.txt > /var/log/OutputFinal.txt
fi

echo "Done!"
