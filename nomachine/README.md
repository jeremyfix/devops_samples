# What is that ?

This scripts provide a sample environment for testing a slurm handled cluster and some other software. 

This has been initially developed to experiment with NoMachine.

It consists of a provisioning node, slurm master node, and some compute nodes.

# Prerequisites

You need to have vagrant as well as a provisionner installed. On a ubuntu host, you can :

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

## Making an allocation

We now need to book a node and the configuration of the cluster will start and allow the user to the nxserver.

```
localhost:~$ vagrant ssh master
vagrant@master:~$ srun --pty bash
vagrant@node1:~$ 
```

you should keep that terminal to keep your session alive.


# TODO

NoMachine was not working out of the box; some weird characters were displayed when the session opeoned. Is that due to missing window manager ?

