#!/bin/bash
#SBATCH --partition=EPYC
#SBATCH --job-name=ex2-epyc-dp
#SBATCH --nodes=1
#SBATCH --cpus-per-task=64
#SBATCH --exclusive
#SBATCH --time=02:00:00

module load architecture/AMD
module load mkl
module load openBLAS/0.3.21-omp

export OMP_PLACES=core
export OMP_PROC_BIND=false
export OMP_NUM_THREADS=64

for size in {2000..20000..1000}
do
        for i in {1..10}
                do ./gemm_oblas.x $size $size $size | grep GFLOPS >> 4-ex2-epyc-oblas-dp-FALSE.dat
        done
done
