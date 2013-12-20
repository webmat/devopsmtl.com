The website for DevOpsMtl is at [www.devopsmtl.com](http://www.devopsmtl.com).

## Prerequisites

```
brew install python ansible
pip install python-keyczar==0.71c
```

## Installation

Enter the host in the `hosts` file. Here's an example:

```ini
[prod]
myserver.com

[next]
mynextserver.com
```

Verify connectivity:

```
ansible all -i hosts -u root -m ping # sanity check
# or target only a section
ansible next -i hosts -u root -m ping
```

Initial bootstrapping

```
ansible-playbook -l next -i hosts bootstrap.yml

# And either
ansible-playbook -i hosts site.yml
ansible-playbook -i hosts site.yml --tags=jetpack
# or
ansible-playbook -l next -i hosts site.yml --extra-vars "server_hostname=test.devopsmtl.com"
```

Remote manual interventions

```
ansible all --sudo -i hosts -m service -a "name=nginx state=reloaded"
ansible all --sudo -i hosts -m service -a "name=php5-fpm state=restarted"
ansible all --sudo -i hosts -m service -a "name=mysql state=restarted"
```


## Backups

### Trigger a backup from workstation

```bash
thor backup:perform
# or limit like Ansible
thor backup:perform -l prod
```

### Trigger a backup from the server

```
sudo backup perform --config-file=/etc/backup/config.rb --trigger=wordpress
```

### Restore the Wordpress backup

```
curl "[s3 url]" > wordpress.tar
tar -xf wordpress.tar
sudo tar -xzf wordpress/archives/uploads.tar.gz -C /srv/wordpress/wp-content/uploads
sudo chown -R wordpress.wordpress /srv/wordpress/wp-content/uploads
gunzip wordpress/databases/MySQL.sql.gz
sudo mysql wp_domtl < wordpress/databases/MySQL.sql
```

## Sysadmin

```
sudo beaver -F string -f /var/log/nginx/*.log
```
