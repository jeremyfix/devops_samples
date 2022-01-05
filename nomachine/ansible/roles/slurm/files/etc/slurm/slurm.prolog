#!/bin/bash
rm prolog.txt
LOG_FILE=prolog.txt

log() {
	echo "[PROLOG] $1" >> $LOG_FILE
}

log "*** Prolog start ********"
log "User $SLURM_JOB_USER, on partition $SLURM_JOB_PARTITION, Job $SLURM_JOB_ID "


/etc/NX/nxserver --startup

# Authorize the user to open a nomachine session
log "Nxserver enabling of $SLURM_JOB_USER"
/usr/NX/bin/nxserver --userenable $SLURM_JOB_USER
active_sessions=`/usr/NX/bin/nxserver --list $SLURM_JOB_USER | tail +5 | head -n -1 | awk '{print $4}' | tr '\n' ' '`
log "Nomachine active sessions $SLURM_JOB_USER : $active_sessions"

STATUS_NOMACHINE=$(systemctl status nxserver | grep Active: );
log "NXSERVER status      : $STATUS_NOMACHINE sur $NODE"

# NoMachine sessions
#####################################################################
active_sessions_node=$(/usr/NX/bin/nxserver --list | grep localhost)
log "sessions nomachine localhost nxserver actives on $NODE : $active_sessions_node"
