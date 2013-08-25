# MrBayes running in parallel, 10 chains, 20000 generations

time mpirun --mca btl_tcp_if_exclude lo,virbr0 -np 6 ./mb primates.nex


2proc,5proc,10proc
17.7,14.7,11.941
17.709,13.04,11.97
17.84,13.08,12.15
20.36,12.96,11.86
17.818,14.01,13.19
