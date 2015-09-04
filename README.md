# security-workshop
Ansible recipe to install HDP ( Hortonworks Data Platform) on a single node VM.

It has been tested on Azure 

Currently, it's working with single DB - MySQL. 

# How To 
Configure repositories and other variables in group_vars/all 

In case of failure, you may want to delete ambari-server package / delete /tmp/blueprint.json and /tmp/host-map.json as if they are present steps are skipped

# TODO
- Implement postgresql
- Implement kerberos
- Implement Ranger
