#!/bin/bash
date >> lidar.txt

while :
do
	i2cset -y 1 0x62 0x00 0x04

	sleep 0.01
	
	# Store the return value in DATA variable
	DATA_LSB=$(i2cget -y 1 0x62 0x10)
	DATA_MSB=$(i2cget -y 1 0x62 0x0f)
	#Left-shift MSB by 1 byte and add it to LSB
	ANS=$(((DATA_MSB << 8) + DATA_LSB))
	echo -n ba >> /dev/ttyAMA0
	printf "%04d" $ANS >> /dev/ttyAMA0
	echo x >> /dev/ttyAMA0
	# echo $ANS >> lidar.txt
done
