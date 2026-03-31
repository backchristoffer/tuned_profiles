#!/bin/bash
#This script is run with bare-metal-gaming.conf and will tune GPU and Intel WiFi. Worth it for laptops

case "$1" in
    start)
        # Force NVIDIA Max Performance
        /usr/bin/nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=1" > /dev/null 2>&1
        
        # Force WiFi Power Management OFF
        echo 2 > /sys/class/net/wlan0/device/power_management
        /usr/sbin/iw dev wlan0 set power_save off
        
        # Force Intel WiFi Driver Power Scheme
        echo 0 > /sys/module/iwlwifi/parameters/power_save
        echo 1 > /sys/module/iwlmvm/parameters/power_scheme
        ;;
esac

exit 0
