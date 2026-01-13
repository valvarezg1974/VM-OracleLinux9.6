#!/bin/bash
set -e

# ---- Configuration ----
USERNAME="grid"
USERHOME="/home/$USERNAME"
SSH_DIR="$USERHOME/.ssh"
KEY_FILE="$SSH_DIR/id_rsa"

# Define your cluster nodes: hostname:IP
# Example for 3 nodes
CLUSTER_NODES=(
  "node1:192.168.1.2"
  "node2:192.168.1.3"
)

# ---- Step 1: Create user if it doesn't exist ----
if ! id "$USERNAME" &>/dev/null; then
    echo "Creating user $USERNAME..."
    sudo useradd -m -s /bin/bash "$USERNAME"
fi

# ---- Step 2: Create .ssh directory ----
sudo -u "$USERNAME" mkdir -p "$SSH_DIR"
sudo chmod 700 "$SSH_DIR"
sudo chown "$USERNAME":"$USERNAME" "$SSH_DIR"

# ---- Step 3: Generate SSH key if missing ----
if [ ! -f "$KEY_FILE" ]; then
    echo "Generating SSH key for $USERNAME..."
    sudo -u "$USERNAME" ssh-keygen -t rsa -b 4096 -f "$KEY_FILE" -N ""
fi

# ---- Step 4: Initialize authorized_keys ----
sudo -u "$USERNAME" cp "$KEY_FILE.pub" "$SSH_DIR/authorized_keys"
sudo chmod 600 "$SSH_DIR/authorized_keys"
sudo chown "$USERNAME":"$USERNAME" "$SSH_DIR/authorized_keys"

# ---- Step 5: Append cluster public keys ----
for node in "${CLUSTER_NODES[@]}"; do
    HOSTNAME="${node%%:*}"
    IP="${node##*:}"
    
    # Copy local public key to authorized_keys (for demo, using /vagrant shared folder)
    PUBKEY_PATH="/vagrant/keys/${HOSTNAME}.pub"
    
    if [ -f "$PUBKEY_PATH" ]; then
        echo "Adding $HOSTNAME public key to authorized_keys"
        sudo -u "$USERNAME" cat "$PUBKEY_PATH" >> "$SSH_DIR/authorized_keys"
    fi
done

sudo chmod 600 "$SSH_DIR/authorized_keys"
sudo chown "$USERNAME":"$USERNAME" "$SSH_DIR/authorized_keys"

echo "ASM/Grid SSH setup completed for $USERNAME on $(hostname)."