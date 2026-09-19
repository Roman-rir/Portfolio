# Innovus init 

#
set var(step) "init"
set vars(init,start_time) [clock seconds]

source -e -v ../project_setup.tcl
source -e -v scripts/always_source.tcl

set init_layout_view ""
set init_abstract_name ""
set init_verilog "$PNR_INIT_NETLIST"
set init_mmmc_file "$PNR_VIEW_DEF"
set init_lef_file "$LEF_FILES"
set init_top_cell "$DESIGN_NAME"
set init_gnd_net "$PNR_GND_NETS"
set init_pwr_net "$PNR_PWR_NETS"

init_design

if { $PNR_FP_PRIORITY == "DEF" } { 
	defIn $PNR_FP_DEF
} else {
	source -e -v $PNR_FP_TCL
}
	
#source scripts/fp.tcl
source scripts/globalNetConnect.tcl

#um::enable_metrics -on
#um::push_snapshot_stack
#puts "<FF> Plugin -> always_source_tcl"
##ff_procs::source_plug always_source_tcl
#loadFPlan DATA/tdsp_core.fp
#source FF/timingderate.sdc
setDontUse *CLK* true
setMaxRouteLayer 6
setDesignMode -process 45
#puts "<FF> Plugin -> post_init_tcl"
#ff_procs::source_plug post_init_tcl
timeDesign -preplace -prefix $var(step) -outDir RPT/$var(step)
checkDesign -all
check_timing
#-------------------------------------------------------------
#
#um::pop_snapshot_stack
#create_snapshot -name init -categories design
report_metric -file RPT/metrics.html -format html
saveDesign DBS/init.enc -compress
saveNetlist DBS/LEC/init.v.gz

exit
