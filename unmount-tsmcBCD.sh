#!/bin/bash
# Unmount remote tsmcBCD directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_DIR="${SCRIPT_DIR}/tsmcBCD"

# Check if mounted
if ! mountpoint -q "${LOCAL_DIR}"; then
    echo "tsmcBCD is not mounted"
    exit 0
fi

# Unmount
echo "Unmounting tsmcBCD..."
fusermount -u "${LOCAL_DIR}"

if [ $? -eq 0 ]; then
    echo "Successfully unmounted tsmcBCD"
else
    echo "Failed to unmount tsmcBCD"
    exit 1
fi
