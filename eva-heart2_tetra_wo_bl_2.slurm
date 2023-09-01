#!/bin/bash -l
#SBATCH --job-name eva-heart2_tetra_wo_bl_2
#SBATCH --mail-user=clement.leger@emse.fr
#SBATCH --mail-type=ALL
#SBATCH --nodes 1
##SBATCH --nodelist=compute-0-18
#SBATCH --ntasks 26
#SBATCH --ntasks-per-node 26 
#SBATCH --mem 100G
#SBATCH --time 60-00:00:00
#SBATCH --partition=all.q

# We load all the default program system settings with module load :
module purge
module load ansys/2022.2


echo Creating SCRATCH directories on nodes $SLURM_JOB_NODELIST...
SCRATCH=/scratch/$USER-$SLURM_JOB_ID
srun -n$SLURM_NNODES mkdir -m 770 -p $SCRATCH  || exit $?
echo ------------------------------------------------------
echo Transferring files from frontend to compute nodes $SLURM_JOB_NODELIST
srun -n$SLURM_NNODES cp -rvf $SLURM_SUBMIT_DIR/* $SCRATCH  || exit $?
echo ------------------------------------------------------

echo "================================================================"
date
echo "================================================================"
echo ""

HOSTS_FILE=hostlist-job${SLURM_JOB_ID}
srun hostname | sort > ${HOSTS_FILE}
echo ${HOSTS_FILE}

## The Journal file
JOURNALFILE=eva-heart2_tetra_wo_bl_2.jou

# Running the program:
echo Run program...
cd $SCRATCH

fluent 3ddp -g -t${SLURM_NTASKS} -i $JOURNALFILE

echo Transferring result files from compute nodes to frontend
srun -n$SLURM_NNODES cp -rvf $SCRATCH  $SLURM_SUBMIT_DIR   || exit $?
echo ------------------------------------------------------
echo Deleting scratch...
srun -n$SLURM_NNODES rm -rvf $SCRATCH  || exit 0
echo ------------------------------------------------------

STATUS=$?

echo "================================================================"
date
echo "================================================================"
echo ""

echo "STATUS = $STATUS"
echo ""
