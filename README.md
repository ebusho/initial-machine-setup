# Fedora initial machine setup

Tested with Fedora 41.

## Prerequisites

Make sure `git` and `ansible` are installed:

```shell
sudo dnf install git python3-pip

python3 -m pip install --user ansible
```

## Steps

1. Clone this repository:

```shell
git clone https://github.com/ebusho/initial-machine-setup.git
```

2. Install dependent roles:

```shell
ansible-galaxy install -r requirements.yaml
```

3. Run Ansible playbook:

```shell
ansible-playbook main.yaml -i hosts -K
```

## Author

This project is created by Alis Adrović (inspired by [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)).
