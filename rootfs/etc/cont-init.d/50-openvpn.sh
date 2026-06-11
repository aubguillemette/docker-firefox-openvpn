#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

# Setup OpenVPN configuration directory
mkdir -p /config/openvpn

if [ -n "${OPENVPN_CONFIG_URL:-}" ]; then
    echo "Downloading OpenVPN configuration from: ${OPENVPN_CONFIG_URL}"
    
    # Download the config file
    if curl -sSL -o /config/openvpn/config.ovpn "${OPENVPN_CONFIG_URL}"; then
        echo "OpenVPN configuration downloaded successfully."
        
        # Ensure the config is readable
        chmod 600 /config/openvpn/config.ovpn
        
        # Create a flag file to signal that OpenVPN should be enabled
        touch /config/openvpn/.enabled
    else
        echo "ERROR: Failed to download OpenVPN configuration from ${OPENVPN_CONFIG_URL}"
        exit 1
    fi
else
    echo "OPENVPN_CONFIG_URL not set. OpenVPN will not be started."
fi
