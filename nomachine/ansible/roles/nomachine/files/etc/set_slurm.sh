#!/bin/bash

echo "Setting nxnode process in user's slurm cgroup."

ppid=`grep '^PPid:' "/proc/$$/status" | cut -f 2`

echo "Nxnode pid $ppid"

slurmuser=`sed -n '1p' /home/vagrant/slurm.info`
#`head -n 1 /home/vagrant/slurm.info`

echo "Slurm user $slurmuser"

slurmid=`sed -n '2p' /home/vagrant/slurm.info`
#`head -n 2 /home/vagrant/slurm.info`

echo "Slurm id $slurmid"

echo $ppid >> /sys/fs/cgroup/cpuset/slurm/uid_1000/job_$slurmid/cgroup.procs

