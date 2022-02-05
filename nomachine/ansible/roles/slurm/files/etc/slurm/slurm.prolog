#!/bin/bash
rm prolog.txt
LOG_FILE=prolog.txt

log() {
	echo "[PROLOG] $1" >> $LOG_FILE
}

log "*** Prolog start ********"
log "User $SLURM_JOB_USER, on partition $SLURM_JOB_PARTITION, Job $SLURM_JOB_ID "

rm /home/$SLURM_JOB_USER/slurm.info
touch /home/$SLURM_JOB_USER/slurm.info

log "Creating /home/$SLURM_JOB_USER/slurm.info"

echo $SLURM_JOB_USER > /home/$SLURM_JOB_USER/slurm.info
echo $SLURM_JOB_ID >> /home/$SLURM_JOB_USER/slurm.info 

#echo 1 >> /sys/fs/cgroup/cpuset/slurm/uid_1000/job_$SLURM_JOB_ID/cgroup.procs
# /etc/NX/nxserver --startup

# Authorize the user to open a nomachine session
log "Nxserver enabling of $SLURM_JOB_USER"
/usr/NX/bin/nxserver --userenable $SLURM_JOB_USER
