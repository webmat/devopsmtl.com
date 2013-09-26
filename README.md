Initial bootstrapping

```
ansible all -i hosts -u root -m ping # sanity check
ansible-playbook -i hosts bootstrap.yml
```
