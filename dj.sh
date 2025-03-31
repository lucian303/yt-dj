#! /bin/bash

sudo echo 2048 > /sys/class/rtc/rtc0/max_user_freq
sudo echo 2048 > /proc/sys/dev/hpet/max-user-freq
sudo dpkg-reconfigure -p high jackd2
sudo cat /sys/kernel/debug/sched/preempt
sudo echo off > /sys/devices/system/cpu/smt/control
sudo cat /sys/kernel/debug/sched/preempt
