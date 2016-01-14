#!/bin/bash
# loads P9_14 pin as pwm on BBB

echo am33xx_pwm > /sys/devices/bone_capemgr.9/slots
echo 3 > /sys/class/pwm/export
echo bone_pwm_P9_14 > /sys/devices/bone_capemgr.9/slots
