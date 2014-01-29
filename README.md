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
# ping an unprovisioned node
ansible next -i hosts -u root -m ping
# or a provisioned node
ansible prod -i hosts -u dieu -m ping
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

## Testing a new server on test.devopsmtl.com

```
# Check state
sudo mysql wp_domtl -e 'select * from wp_options where option_value like "%www.devopsmtl.com%" \G'
# Point wordpress to test.devopsmtl.com
sudo mysql wp_domtl -e "update wp_options set option_value = 'http://test.devopsmtl.com' where option_name in ('home', 'siteurl');"
# Point wordpress back to www.devopsmtl.com
sudo mysql wp_domtl -e "update wp_options set option_value = 'http://www.devopsmtl.com' where option_name in ('home', 'siteurl');"
```

## Sysadmin

```
sudo beaver -F string -f /var/log/nginx/*.log
```
