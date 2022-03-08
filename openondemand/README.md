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

## Progress

For now , blocking on

```
TASK [osc.open_ondemand : build the project (this will take some time)] ********
ASYNC POLL on master: jid=958051907056.25870 started=1 finished=0
ASYNC FAILED on master: jid=958051907056.25870
fatal: [master]: FAILED! => {"ansible_job_id": "958051907056.25870", "changed": true, "cmd": "rake build -mj$(nproc) > build.out 2>&1", "delta": "0:03:09.820572", "end": "2022-03-08 18:56:25.775190", "finished": 1, "msg": "non-zero return code", "rc": 1, "results_file": "/home/vagrant/.ansible_async/958051907056.25870", "start": "2022-03-08 18:53:15.954618", "started": 1, "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
```

but where is this build.out file stored  to access some info ?
