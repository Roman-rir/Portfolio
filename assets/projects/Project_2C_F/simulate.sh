xmvlog -sv -f file_list.f 

xrun -sv -access +rwc +gui design.sv testbench.sv -coverage all
