# Building this project

This file explains how to build this project on AWS.  If you're looking for the dev vagrant, its readme is in the `dev_vagrant` subdirectory.

## Architecture

This project needs the following types of instances to run:

- `tag_Ansible_Db` - runs the postgres database; rambler commands are expected here
- `tag_Ansible_Back` - runs the queue reader service that listens for calculation requests and builds the calendar for a given time frame
- `tag_Ansible_Front` - runs the API that listens for calendar requests and pushes messages to the queue if not found
- `tag_Ansible_Master` - a small instance within the project security group from which Ansible commands are run to update the others

## Boostrapping master

First, you'll need the keys placed in your ssh directory.  You can of course copy them from the secrets file, but running the playbook is easier:

```
ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook build/ansible/local.yml --ask-vault-pass
```

Once you've done that, you can bootstrap the master instance:

```
ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook build/ansible/master.yml --ask-vault-pass --private-key=~/.ssh/ec2_deploy_id_rsa
```

This will spin up a new master instance and run the `ansible_master` role on it. Because we're using localhost rather than a dynamic inventory, it can only find the ansible master when it's first created.

