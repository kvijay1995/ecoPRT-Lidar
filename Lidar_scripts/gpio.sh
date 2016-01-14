#!/bin/bash

gpio_sysfs=/sys/class/gpio

load_gpio () {
	num=$1
	if [ ! -e $gpio_sysfs/gpio${num} ]; then
		echo $num > ${gpio_sysfs}/export
	else
		echo "GPIO $num already exported"
	fi
	echo in > ${gpio_sysfs}/gpio${num}/direction
}

set_gpio () {
	num=$1
	dir=$2
	if [ "$dir" = 'out' ]; then
		val=$3
		echo $dir > ${gpio_sysfs}/gpio${num}/direction
		echo $val > ${gpio_sysfs}/gpio${num}/value
	else
		echo $dir > ${gpio_sysfs}/gpio${num}/direction
	fi
}
