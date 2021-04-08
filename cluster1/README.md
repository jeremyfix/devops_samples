This defines a cluster with a master and 4 nodes  .... **Not yet fully functional, I will give a try to deepops which intregates the installation of slurm, openondemand, monitoring, etc...**

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

I do use some unelegant hacks. I'm not familiar enough with ansible, using marvel-nccr role to install slurm but then add a playbook to change the default installation. Probably should be using variables for parametrizing the job done by marvel-nccr ? Also, this role is running the slurmctl and slurmd on all the nodes while slurmctld should be only running on the master and slurmd on the nodes.

For some reasons, after the install, if we log on master.local  with `ssh vagrant@master.local` and look at the nodes `sinfo`, node2 and node4 appears UNK* or DOWN* while node1 and node3 are up and idle. You can try a job with `srun --pty bash`, should be ending on node1 or node3.

## Installing open ondemand

We will be using the [ood-ansible](https://github.com/OSC/ood-ansible) role.


	ansible-playbook playbook.yml -i hosts --extra-vars=@ood.yml
