## Fedora Workstation 32 initial machine setup



### Steps

- Install Ansible.

- Clone this repository to your local drive.

- Run:

  ```bash
  ansible-galaxy install -r requirements.yaml
  ```
  inside this directory to install required Ansible roles.

- Run:

  ```bash
  ansible-playbook main.yaml -i inventory -K
  ```
  inside this directory.
  
- Enter your account password when prompted.

