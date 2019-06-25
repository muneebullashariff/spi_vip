#!usr/bin/perl

system "vlib work";
system "vmap work work";
#for compilation
system "vlog -work work -sv +incdir+../source/master +incdir+../source/slave +incdir+../source/tb +incdir+../source/test ../source/test/test_pkg.sv ../source/tb/top.sv";

#for simulation
system "vsim -voptargs=\"+acc=rnb\" -l ral_sim.log +UVM_VERBOSITY=UVM_HIGH -novopt top -c -do \"log -r /*; add wave -r /*; run -all;\" +UVM_TESTNAME=test -wlf waveform.wlf";

## +acc=rnb 
## Compile my design so that all of it has:
## registers (r)
## nets (n)
## vector bits (b)
## Visible so that backdoor access will work correctly
