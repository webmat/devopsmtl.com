The website for DevOpsMtl is at [devopsmtl.com](http://www.devopsmtl.com).

## Prerequisites

```
brew install python ansible
pip install python-keyczar==0.71c
```

Initial bootstrapping

```
ansible all -i hosts -u root -m ping # sanity check
ansible-playbook -l "name*" -i hosts bootstrap.yml
# Set the ansible_ssh_user in the inventory file
ansible-playbook -i hosts site.yml
# or
ansible-playbook -i dev site.yml --extra-vars "server_hostname=test.devopsmtl.com"
```

Remote manual interventions

```
ansible all --sudo -i hosts -m service -a "name=nginx state=reloaded"
ansible all --sudo -i hosts -m service -a "name=php5-fpm state=restarted"
ansible all --sudo -i hosts -m service -a "name=mysql state=restarted"
```
