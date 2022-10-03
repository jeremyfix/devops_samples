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

you should keep that terminal to keep your session alive. The above command allocated a node, started NoMachine and registered the vagrant user in the NX database.

The next step is to ssh-tunnel to the node which can be done with

```
localhost:~$ ssh -i ./.vagrant/machines/master/virtualbox/private_key -p 2222 -L 4000:node1:4000 vagrant@localhost
```

The above command **must** be executed from your vagrant directory (the one where this Readme is) to be able to access the ssh key of your virtual boxes.

And finally you can start the NoMachine client on your host and open a session to localhost:4000 with username `vagrant` and password `vagrant`.


![NoMachine session running on the vagrant VM allocated with slurm](https://github.com/jeremyfix/devops_samples/blob/main/nomachine/screennomachine.png?raw=true)

## Testing the cgroups

cgroups are containers for all the processes that a user can run and defines some resource constraints. When you make an allocation with slurm, it creates a cgroup so that every processes ran by the user are killed once the allocation terminates.

### A simple example that works

A simple way to illustrate that is to do the following

```
localhost:~$ vagrant ssh master
vagrant@master:~$ srun --pty bash
vagrant@node1:~$ echo $SLURM_JOB_ID
```

Let us keep that terminal active. The last command displays the job id of your allocation. Suppose this is 1234. To illustrate the release of the cgroup, let us start a new ssh connection to the compute node within the cgroup create by slurm. We can do that easily by running a bash providing the previous job id to slurm. 

We ssh to the master node

```
localhost:~$ vagrant ssh master
vagrant@master:~$ SLURM_JOB_ID=1234 srun --pty bash
```

Now, exit from the first terminal (the very first from which the allocation was created). In the second terminal, you should also notice your connection has been closed with a message like :

```
vagrant@node1:~$ srun: Job step aborted: Waiting up to 32 seconds for job step to finish.
exit
vagrant@master:~$
```

This is because the cgroup was destroyed and the second bash process was then killed.


### A simple example that fails

Now, for the moment, with our current configuration, if a user starts the NoMachine session and stops its slurn allocation, the NoMachine session is not stopped

**Note** with our current prologs/epilogs which we use in production, actually the session is killed


### A memory example that fails

**TODO** : I'm trying to configure mem limits in cgroups and try memory allocation. With memtester 
memtester 1500M 1 get killed  in the srun
