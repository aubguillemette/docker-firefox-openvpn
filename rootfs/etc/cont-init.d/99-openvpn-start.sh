#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

# Start OpenVPN in the background if enabled
if [ -f /config/openvpn/.enabled ] && [ -f /config/openvpn/config.ovpn ]; then
    echo "Starting OpenVPN in background..."
    
    # Create log file
    mkdir -p /config/openvpn
    
    # Build OpenVPN command
    OPENVPN_CMD="/usr/sbin/openvpn --config /config/openvpn/config.ovpn \
        --script-security 2 \
        --log /config/openvpn/openvpn.log"
    
    # Add auth file if it exists
    if [ -f /config/openvpn/auth.txt ]; then
        OPENVPN_CMD="$OPENVPN_CMD --auth-user-pass /config/openvpn/auth.txt"
    fi
    
    # Add daemon flag
    OPENVPN_CMD="$OPENVPN_CMD --daemon openvpn"
    
    # Run OpenVPN
    eval "$OPENVPN_CMD"
    
    sleep 5
    
    if [ -f /config/openvpn/openvpn.log ]; then
        echo "OpenVPN log:"
        tail -10 /config/openvpn/openvpn.log
    fi
    
    echo "OpenVPN started."
fi
