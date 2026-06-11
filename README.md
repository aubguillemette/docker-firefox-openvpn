# Docker + Firefox + OpenVPN
Based off of jlesage's repo. I made this because I wanted an OpenVPN connection for a browser that did not mess with my system wide connections.
Original repo here: [https://github.com/jlesage/docker-firefox](https://github.com/jlesage/docker-firefox)
Copy of the original README here: [ORIGINAL_README.md](ORIGINAL_README.md)

# How do I use it
For more advanced use-cases, refer to the [original repo](https://github.com/jlesage/docker-firefox) or the [original readme](ORIGINAL_README.md), but for most use cases:

```shell
docker run -d \
    --name=firefox \
    -p 5800:5800 \
    -v /docker/appdata/firefox:/config:rw \
    aubguillemette/firefox-openvpn
```

With OpenVPN (requires additional capabilities):

```shell
docker run -d \
    --name=firefox \
    -p 5800:5800 \
    -v /docker/appdata/firefox:/config:rw \
    --cap-add=NET_ADMIN \
    --device=/dev/net/tun \
    -e OPENVPN_CONFIG_URL="https://example.com/path/to/config.ovpn" \
    aubguillemette/firefox-openvpn
```

Or with VPN credentials (if required):

```shell
docker run -d \
    --name=firefox \
    -p 5800:5800 \
    -v /docker/appdata/firefox:/config:rw \
    --cap-add=NET_ADMIN \
    --device=/dev/net/tun \
    -e OPENVPN_CONFIG_URL="https://example.com/path/to/config.ovpn" \
    -e OPENVPN_USERNAME="your_username" \
    -e OPENVPN_PASSWORD="your_password" \
    aubguillemette/firefox-openvpn
```

## Parameters

  - `/docker/appdata/firefox`: Stores the application's configuration, state, logs, and any files requiring persistency.
  - `OPENVPN_CONFIG_URL` (optional): URL to your OpenVPN configuration file. When set, OpenVPN will be automatically downloaded and started. Omit to run Firefox without VPN.
  - `OPENVPN_USERNAME` (optional): OpenVPN username for authentication. Only required if your VPN config requires credentials.
  - `OPENVPN_PASSWORD` (optional): OpenVPN password for authentication. Only required if your VPN config requires credentials.
  - `DNS_SERVERS`: DNS servers to use (default: "1.1.1.1 8.8.8.8"). You can override this with your preferred DNS servers.

## Docker Flags

When using OpenVPN, these additional Docker flags are required:

  - `--cap-add=NET_ADMIN`: Allows OpenVPN to create and manage network interfaces.
  - `--device=/dev/net/tun`: Exposes the TUN device for OpenVPN tunneling.

Don't put these flags if you're not using OpenVPN (but if you're not, you should be using jlesage's image anyway)

Access the Firefox GUI by browsing to `http://your-host-ip:5800`.

# Credits
Most of the heavy lifting was already done by jlesage. Thanks jlesage. Send all donations to him.

Rock n' roll.