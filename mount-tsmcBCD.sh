#!/bin/bash
# Mount remote tsmcBCD directory locally

# Configuration
SERVER="ee4610.ewi.tudelft.nl"
NETID="datyukov"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_DIR="${SCRIPT_DIR}/tsmcBCD"
REMOTE_DIR="tsmcBCD"

# Get password from file
PASSWORD=$(grep "^password:" "${SCRIPT_DIR}/password_username.txt" | awk '{print $2}')

# Check if already mounted
if mountpoint -q "${LOCAL_DIR}"; then
    echo "tsmcBCD is already mounted"
    exit 0
fi

# Mount the remote directory
echo "Mounting remote tsmcBCD directory..."
echo "${PASSWORD}" | sshfs ${NETID}@${SERVER}:${REMOTE_DIR} "${LOCAL_DIR}" \
    -o password_stdin \
    -o reconnect \
    -o ServerAliveInterval=15 \
    -o ServerAliveCountMax=3 \
    -o follow_symlinks

if [ $? -eq 0 ]; then
    echo "Successfully mounted tsmcBCD at ${LOCAL_DIR}"
else
    echo "Failed to mount tsmcBCD"
    exit 1
fi
