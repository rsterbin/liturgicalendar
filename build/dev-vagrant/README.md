# Setting up a dev environment ##

This will help you set up a development environment.

## Install list ##

1. Install [Ansible](http://docs.ansible.com/ansible/intro_installation.html#getting-ansible)
2. Install [Vagrant](https://www.vagrantup.com/docs/installation/)
3. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
4. Install the vagrant triggers plugin:

        $ vagrant plugin install vagrant-triggers

5. Install the ansible roles:

        $ ansible-galaxy install -r ../ansible/install_roles.yml

## Bring up your environment ##

This will set up your vagrant environment:

```
$ vagrant up
```

Your new vagrant environment will contain three virtual boxes:

* `front` - this box serves json for the website to consume
* `back` - this box provides the admin interface
* `db` - this box runs the database

Once you're set up, you can ssh into them by name (e.g. `vagrant ssh back`) or access them via other ports using the IP addresses assigned to them (see below).

## Tweak your private network addresses (optional) ##

By default your virtual boxes will take the following private network addresses:

| Name   | Default IP   | Config Key |
| ------ | ------------ | ---------- |
| front  | 192.168.0.23 | front_ip   |
| back   | 192.168.0.24 | back_ip    |
| db     | 192.168.0.25 | db_ip      |

You can change these values by creating a file called `config.yml` in this directory:

```
---
# Configure my vagrant
front_ip: 192.168.0.77
db_ip: 192.168.0.102
...
```

After you've changed your config file, you'll need to destroy and reinstate your vagrant to see the changes:

```
$ vagrant destroy -f && vagrant up
```

## Provision your environment ##

For dev, you'll need to use a custom ansible configuration, so run all ansible commands you intend for your vagrant environment from this directory, even though the playbook file is in the ansible directory next to this one.

```
$ ansible-playbook ../ansible/init_vagrant.yml --ask-vault-pass
```

