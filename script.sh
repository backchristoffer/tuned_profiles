#!/bin/bash
case "$1" in
    start)
        # Force NVIDIA Max Performance
        /usr/bin/nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=1" > /dev/null 2>&1
        
        # Force NVIDIA GPU to Maximum Performance Mode
        nvidia-smi -pm 1 # Enable Persistence Mode
        
        # MSI GE66 3070 usually caps around 125W-130W, sometimes 140W. 
        # Setting 140 is fine; the card will just take its physical max. - For now it seems to go as high as 101W with a laptop
        nvidia-smi -pl 140 
        # If you ever get thermal throttling, you can use --lock-gpu-clocks=1100,1650 

        # Force WiFi Power Management OFF
        echo 2 > /sys/class/net/wlan0/device/power_management
        /usr/sbin/iw dev wlan0 set power_save off

        # Force Intel WiFi Driver Power Scheme
        echo 0 > /sys/module/iwlwifi/parameters/power_save
        echo 1 > /sys/module/iwlmvm/parameters/power_scheme
        ;;
esac
exit 0
