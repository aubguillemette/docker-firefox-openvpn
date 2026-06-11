#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

# Set DNS for the container
DNS_SERVERS="${DNS_SERVERS:-1.1.1.1 8.8.8.8}"

echo "Setting DNS servers to: $DNS_SERVERS"

# Backup the original resolv.conf if it exists
if [ -f /etc/resolv.conf ]; then
    cp /etc/resolv.conf /etc/resolv.conf.bak
fi

# Create a new resolv.conf with specified DNS servers
: > /etc/resolv.conf

for dns in $DNS_SERVERS; do
    echo "nameserver $dns" >> /etc/resolv.conf
done

# Make it immutable so other processes don't override it
chattr +i /etc/resolv.conf 2>/dev/null || true

echo "DNS configured."
cat /etc/resolv.conf
