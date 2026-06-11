#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

# Setup OpenVPN credentials if provided
if [ -n "${OPENVPN_USERNAME:-}" ] && [ -n "${OPENVPN_PASSWORD:-}" ]; then
    echo "Setting up OpenVPN credentials..."
    
    mkdir -p /config/openvpn
    
    # Create credentials file
    cat > /config/openvpn/auth.txt <<EOF
${OPENVPN_USERNAME}
${OPENVPN_PASSWORD}
EOF
    
    # Secure permissions
    chmod 600 /config/openvpn/auth.txt
    
    echo "OpenVPN credentials configured."
fi
