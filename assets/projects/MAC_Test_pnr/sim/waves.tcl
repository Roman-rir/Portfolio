database -open waves.shm -shm -default
probe -create -shm $::env(SIM_TOP) -depth all -all
run
