#!/bin/bash

# Create tap devices for the emulation

TAP_STA="tap-lte-sta"
TAP_STA_MAC="aa:bb:cc:00:00:01"

TAP_BS=="tap-lte-bs"
TAP_BS_MAC="aa:bb:cc:00:00:02"

# Wait a bit for the other nodes to be ready
sleep 30

EXTERNAL_BS_MAC=$(sudo arping 10.0.0.42 -c 1 | grep -o "..:..:..:..:..:..")
EXTERNAl_STA_MAC=$(sudo arping 10.0.0.42 -c 1 | grep -o "..:..:..:..:..:..")

ip tuntap add mode tap ${TAP_STA}
ip link set ${TAP_STA} address ${TAP_STA_MAC}
ip link set ${TAP_STA} up

ip tuntap add mode tap ${TAP_BS}
ip link set ${TAP_BS} address ${TAP_STA_BS}
ip link set ${TAP_BS} up

# Run the emulation
lte_emulator --isFading=true              \
             --distance=0                 \
             --bs-x=0.0                   \
             --bs-mac=4e:fe:c5:d3:1a:9b   \
             --bs-y=0.0                   \
             --n-sta=1                    \
             --sta-list=sta               \
             --bs-name=bs                 \
             --experiment-id=exp1         \
             --sta-taps=${TAP_STA}        \
             --bs-tap=${TAP_BS}           \
             --sta-macs=1a:6e:e2:c6:be:5d \
             --control-port=41010         \
             --sta-ips=192.168.19.13/24   \
             --bs-ip=192.168.19.12/24     \
             --printIP=true               \
             --logging=true               \
             --txBuffer=8000000

# Set iptables rules
