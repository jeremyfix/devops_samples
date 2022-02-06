#!/bin/bash

echo "Setting nxnode process in user's slurm cgroup."

ppid=`grep '^PPid:' "/proc/$$/status" | cut -f 2`
echo "Nxnode pid $ppid"

# Retrieving the unix user name
nomachine_login=`echo /proc/$ppid/cmdline | grep -oP "\-\-user\s+\K\w+"`
echo "NoMachine login $nomachine_login"

#TODO:
# A user may be opening a session with a username different from
# the one used for allocating with slurm

# Retrieving the slurmuser
# slurmuser=`sed -n '1p' /home/$login/.slurm.info`
# echo "Slurm user $slurmuser"

#TODO Check the .slurm.info file exists; otherwise, this means there is no
# slurm allocation and we should fail

# Retrieving the most recent slurm job id for the user 
slurmid=`sed -n '2p' /home/$nomachine_login/.slurm.info`
echo "Slurm id $slurmid"

uid=`id -i $nomachine_login`
echo "User id $uid"

#TODO: Check the file /uid_$uid/job_$slurmid/cgroup.procs exists

echo $ppid >> /sys/fs/cgroup/cpuset/slurm/uid_$uid/job_$slurmid/cgroup.procs
echo "PID $ppid added to the cgroup /sys/fs/cgroup/cpuset/slurm/uid_$uid/job_$slurmid/cgroup.procs"
