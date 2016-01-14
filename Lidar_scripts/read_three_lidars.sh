#!/bin/bash

dir=$(dirname $0)
source $dir/gpio.sh

load_gpio 16
load_gpio 20
load_gpio 21

set_gpio 16 out 0
set_gpio 20 out 0 
set_gpio 21 out 0

read_lidar () {
	num=$1
	set_gpio ${num} out 1
        i2cset -y 1 0x62 0x00 0x04

        sleep 0.01

        # Store the return value in DATA variable
        DATA_LSB=$(i2cget -y 1 0x62 0x10)
        DATA_MSB=$(i2cget -y 1 0x62 0x0f)
        #Left-shift MSB by 1 byte and add it to LSB
        ANS=$(((DATA_MSB << 8) + DATA_LSB))
#        echo gpio $num : $ANS
	printf "%04d" $ANS > /dev/ttyAMA0
	set_gpio ${num} out 0
}
while :
do
	echo -n ba > /dev/ttyAMA0
	read_lidar 16
#	read_lidar 20
#	read_lidar 21
	echo x > /dev/ttyAMA0
done
	
	

#set_I2C_addr () {
#	gpio_n=$1
#	new_I2C=$2
#
#	set_gpio ${gpio_n} out 1
#
#	ser1=$(i2cget -y 1 0x62 0x16)
#	ser2=$(i2cget -y 1 0x62 0x17)
#	echo $ser1
#	echo $ser2
#	i2cset -y 1 0x62 0x18 ${ser1}
#	i2cset -y 1 0x62 0x19 ${ser2}
#	i2cset -y 1 0x62 0x1a ${new_I2C}
#	i2cset -y 1 0x62 0x1e 0x01
#	i2cset -y 1 0x62 0x1e 0x08
#}
#
#sleep 0.1
#set_I2C_addr 16 52
##sleep 0.1
##set_I2C_addr 21 72
