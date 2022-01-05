# What is that ?

This scripts provide a sample environment for testing a slurm handled cluster and some other software. 

This has been initially developed to experiment with NoMachine.

It consists of a provisioning node, slurm master node, and some compute nodes.

# Prerequisites

You need to have vagrant as well as a provisionner installed. On a ubuntu host, you can :

	sudo apt install vagrant vagrant-virtualbox -y

# Installation

To start the cluster :

```
vagrant up
```

For some reasons, during the ansible playbook the creation of the slurm accoutn failed because the slurmd and slurmdbd services were not running ... even if the playbook contains the notify to the handlers to restart these services !



I also had to manually fill in the slurm.conf specifications of the compute nodes given what I saw in the slurmd.log on the compute node. Is it possible to specify to vagrant how many CPUs to use ?

Now I see the node1 running and idle; 

Next step :  define a common user (the vagrant one ?) able to ssh from the master to node 1

sudo sacctmgr add account demoaccount Description="Demo account"
sudo sacctmgr create user name=vagrant DefaultAccount=demoaccount


almost running : need to script the vagrant password free ssh key ; and also check that the slurm-taskprolog is no more complaining when runn srun --pty bash
