# What is that ?

This scripts provide a sample environment for testing a slurm handled cluster and Open OnDemand

It consists of a provisioning node, slurm master node, and some compute nodes.

# Prerequisites

You need to have vagrant as well as a provisioner installed. On a ubuntu host, you can :

	sudo apt install vagrant vagrant-virtualbox -y

# Installation

## Booting the cluster

To start the cluster :

```
vagrant up
```

To check everything works, you can log to the SLURM master node and book a node :

```
localhost:~$ vagrant ssh master
vagrant@master:~$ sinfo
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST 
cpupart*     up    4:00:00      1   idle node1

vagrant@master:~$ srun --pty bash
vagrant@node1:~$ 
```

You can then close your session by exiting the two ssh connections (to node1 and then to master).

The critical point is the sinfo which should output the state `idle` for the node. And finally note the last command brings your user to `node1`.

## Connecting to open on demand

**TBD**
