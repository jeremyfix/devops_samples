This defines a cluster with a master and 4 nodes

After `vagrant up` we can ping and access them.

Roadmap:

- see the ansible roles for slurm : https://galaxy.ansible.com/marvel-nccr/slurm
	- see the configuration of [slurm for a testable example](https://southgreenplatform.github.io/trainings/hpc/slurminstallation/)
- see the goffinet tutorials

for deploying on bare metal machines : https://github.com/Teradata/stacki-ubuntu

# Installation

We assume the user runnning vagrant up has a ssh-key; It will be copied during the provisioning of the VMs.

First we start the local cluster:

	vagrant up

## ssh

You can ssh to a machine with 

	vagrant ssh master

or 

	ssh vagrant@master.local -i .vagrant/machines/master/virtualbox/private_key

## Ansible

You can test ansible with :

	ANSIBLE_HOST_KEY_CHECKING=False ansible cluster -i hosts -m ping

You have to install the requirements :

	ansible-galaxy install -r requirements.yml

## Installing slurm

Then we install slum with the slurm ansible role

	ansible-galaxy install marvel-nccr.slurm
	ansible-playbook playbook.yml -i hosts
