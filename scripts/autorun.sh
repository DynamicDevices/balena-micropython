#!/bin/bash

# Disable serial console
#
# NOTE: Currently have to do this on host OS which is not ideal!
#
# mount -o remount,rw /
# systemctl mask serial-getty@serial0.service
#

# Load in driver for MEMS microphone
if [ ! -z "`lsmod | grep rpi0-i2s-audio`" ]; then
insmod rpi0-i2s-audio.ko && 1
fi

# Run Witty init.sh (No longer using this in the stack)
#if [ -f /home/pi/wittypi/init.sh ];then
#sh /home/pi/wittypi/init.sh start
#fi

if [ "${AUTORUN}" == "1" ] || [ "${AUTORUN}" == "true" ]; then
 ./runmqtt.sh
if [ "${AUTOOFF}" == "1" ] || [ "${AUTOOFF}" == "true" ]; then
# NOTE: Standard shutdown script not available in Balena and
#       I don't want to use the supervisor API so have provided
#       a script here that uses SysReq to sync the system then
#       tell our power controller to turn us off.
shutdown
fi
else
 ./sleep.sh
fi
