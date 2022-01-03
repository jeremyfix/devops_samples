# What is that ?

This scripts provide a sample environment for testing a slurm handled cluster and some other software. 

This has been initially developed to experiment with NoMachine.

It consists of a provisioning node, slurm master node, and some compute nodes.

# Installation

To start the cluster :

```
vagrant up
vagrant provision
```


To be done manually yet, during the installation:
```
vagrant@master:~$ sudo mysql
MariaDB [(none)]> grant all on slurm_acct_db.* TO 'slurm'@'localhost' identified by 'slurmpass' with grant option;
MariaDB [(none)]> create database slurm_acct_db;
MariaDB [(none)]> quit;
```

for some reasons the munge key was different from the master and the compute nodes, saw that from the master  /var/log/slurm/slurmctld.log 

I also had to manually fill in the slurm.conf specifications of the compute nodes given what I saw in the slurmd.log on the compute node. Is it possible to specify to vagrant how many CPUs to use ?

Now I see the node1 running and idle; 

Next step :  define a common user (the vagrant one ?) able to ssh from the master to node 1

sudo sacctmgr add account demoaccount Description="Demo account"
sudo sacctmgr create user name=vagrant DefaultAccount=demoaccount


almost running : need to script the vagrant password free ssh key ; and also check that the slurm-taskprolog is no more complaining when runn srun --pty bash
