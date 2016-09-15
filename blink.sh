#!/bin/bash

if [ ! -d /sys/class/gpio/gpio60 ];
	then echo 60 > /sys/class/gpio/export;
fi

echo low > /sys/class/gpio/gpio60/direction	#for making the pin as an output pin

for (( i=0 ; ; ++i ))
do

   echo 0 > /sys/class/gpio/gpio60/value
   sleep .2
   echo 1 > /sys/class/gpio/gpio60/value

done

