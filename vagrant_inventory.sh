#!/bin/bash

VM_NAME="initial-machine-setup-box"

# Check if VM is running
VM_STATE=$(vagrant status "$VM_NAME" --machine-readable | grep ",state," | cut -d',' -f4)

if [[ "$VM_STATE" != "running" ]]; then
  echo "ERROR: VM '$VM_NAME' is not running (current state: $VM_STATE). Start it with 'vagrant up'." >&2
  exit 1
fi

# Get SSH config and extract fields using exact match
SSH_CONFIG=$(vagrant ssh-config "$VM_NAME")

HOST=$(echo "$SSH_CONFIG" | awk '$1 == "HostName" { print $2 }')
USER=$(echo "$SSH_CONFIG" | awk '$1 == "User" { print $2 }')
PORT=$(echo "$SSH_CONFIG" | awk '$1 == "Port" { print $2 }')
KEY=$(echo "$SSH_CONFIG" | awk '$1 == "IdentityFile" { print $2 }')

# Validate fields
if [[ -z "$HOST" || -z "$USER" || -z "$PORT" || -z "$KEY" ]]; then
  echo "ERROR: Failed to extract necessary SSH fields from 'vagrant ssh-config' for VM '$VM_NAME'." >&2
  exit 1
fi

# Output inventory JSON
cat <<EOF
{
  "vagrant": {
    "hosts": ["$VM_NAME"],
    "vars": {
      "ansible_host": "$HOST",
      "ansible_user": "$USER",
      "ansible_port": "$PORT",
      "ansible_ssh_private_key_file": "$KEY",
      "ansible_python_interpreter": "/usr/bin/python3"
    }
  },
  "_meta": {
    "hostvars": {
      "$VM_NAME": {
        "ansible_host": "$HOST",
        "ansible_user": "$USER",
        "ansible_port": "$PORT",
        "ansible_ssh_private_key_file": "$KEY",
        "ansible_python_interpreter": "/usr/bin/python3"
      }
    }
  }
}
EOF
