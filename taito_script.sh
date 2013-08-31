# module swap intel gcc/4.7.2
# module swap intelmpi  openmpi/1.6.4
# module load R/2.15.3

# R R-2.15.3 environment loaded
# 
# ---------------------------------------------------------------- 
# R in Taito
# ---------------------------------------------------------------- 
# To run R interactively,
    # salloc -n 1 -t hh:mm:ss R
# A sample batch job file for R,
    # #!/bin/bash
    # #SBATCH -J r_job
    # #SBATCH -o output.txt
    # #SBATCH -e errors.txt
    # #SBATCH -t hh:mm:ss
    # #SBATCH --nodes=1
    # #SBATCH --ntasks=1
    # #SBATCH --mem-per-cpu=1000
    # #
    # module load R.latest
    # R --no-save < my_r_script.R
# A sample batch job file for parralel R,
    # #!/bin/bash
    # #SBATCH -J rmpi_job
    # #SBATCH -o output.txt
    # #SBATCH -e errors.txt
    # #SBATCH -t hh:mm:ss
    # #SBATCH --nodes=1
    # #SBATCH --ntasks=8
    # #SBATCH --mem-per-cpu=200
    # #
    # module load R.latest
    # mpirun -np 1 R --no-save < my_rmpi_script.R
               # // or alternatively //
    # srun -n 8 --resv-ports Rmpi --no-save < my_rmpi_script.R
    # (if using the latter, do not spawn slaves)
# ---------------------------------------------------------------- 
# 
