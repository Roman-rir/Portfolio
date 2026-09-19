## Template Script for RTL->Gate-Level Flow (generated from GENUS 17.10-p007_1) 

if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
    sh grep "cpu MHz"    /proc/cpuinfo
    }

    puts "Hostname : [info hostname]"

set var(step) "synth"
if {[file exists $::env(REPO_ROOT)/project_setup.tcl]} {
	source -e -v $::env(REPO_ROOT)/project_setup.tcl
}

##############################################################################
## Preset global variables and attributes
##############################################################################
set DESIGN $DESIGN_NAME
puts "DESIGN SET TO $DESIGN"
set GEN_EFF $SYNTH_EFFORT_GENERIC
set MAP_OPT_EFF $SYNTH_EFFORT_OPT
set DATE [clock format [clock seconds] -format "%b%d-%T"]
set _OUTPUTS_PATH outputs_${DATE}
set _REPORTS_PATH reports_${DATE}
set _LOG_PATH logs_${DATE}
##set ET_WORKDIR <ET work directory>
set_db / .init_lib_search_path  {. ../LIB $TECH_DIR}
##set_db / .script_search_path {. <path>} 
set_db / .init_hdl_search_path  {. ../RTL $DESIGN_DIR}
##Uncomment and specify machine names to enable super-threading.
##set_db / .super_thread_servers {<machine names>} 
##For design size of 1.5M - 5M gates, use 8 to 16 CPUs. For designs > 5M gates, use 16 to 32 CPUs
##set_db / .max_cpus_per_server 8

##Default undriven/unconnected setting is 'none'.  
##set_db / .hdl_unconnected_input_port_value 0 | 1 | x | none 
##set_db / .hdl_undriven_output_port_value   0 | 1 | x | none
##set_db / .hdl_undriven_signal_value        0 | 1 | x | none 


##set_db / .wireload_mode <value> 
set_db / .information_level $SYNTH_INFO_LEVEL

###############################################################
## Library setup
###############################################################


eval "set_db / .library {$LIB_FILES(all)}"
## PLE
eval "set_db / .lef_library  {$LEF_FILES}"
## Provide either cap_table_file or the qrc_tech_file

if {$SYNTH_LOW_POWER == "true" } {
set_db / .lp_insert_clock_gating true 
}

## Power root attributes
#set_db / .lp_clock_gating_prefix <string>
#set_db / .lp_power_analysis_effort <high> 
#set_db / .lp_power_unit mW 
#set_db / .lp_toggle_rate_unit /ns 
## The attribute has been set to default value "medium"
## you can try setting it to high to explore MVT QoR for low power optimization
#
if {$SYNTH_LOW_POWER == "true" } {
set_db / .leakage_power_effort high 
} else {
set_db / .leakage_power_effort medium 
}


####################################################################
## Load Design
####################################################################


read_hdl -sv "$RTL_FILES"
eval "elaborate $DESIGN"
puts "Runtime & Memory after 'read_hdl'"
time_info Elaboration



check_design -unresolved

####################################################################
## Constraints Setup
####################################################################

read_sdc $CONSTRAINTS_FILE 
puts "The number of exceptions is [llength [vfind "design:$DESIGN" -exception *]]"


#set_db "design:$DESIGN" .force_wireload <wireload name> 

if {![file exists ${_LOG_PATH}]} {
  file mkdir ${_LOG_PATH}
  puts "Creating directory ${_LOG_PATH}"
}

if {![file exists ${_OUTPUTS_PATH}]} {
  file mkdir ${_OUTPUTS_PATH}
  puts "Creating directory ${_OUTPUTS_PATH}"
}

if {![file exists ${_REPORTS_PATH}]} {
  file mkdir ${_REPORTS_PATH}
  puts "Creating directory ${_REPORTS_PATH}"
}
check_timing_intent


###################################################################################
## Define cost groups (clock-clock, clock-output, input-clock, input-output)
###################################################################################

## Uncomment to remove already existing costgroups before creating new ones.
## delete_obj [vfind /designs/* -cost_group *]

if {[llength [all_registers]] > 0} { 
  define_cost_group -name I2C -design $DESIGN
  define_cost_group -name C2O -design $DESIGN
  define_cost_group -name C2C -design $DESIGN
  path_group -from [all_registers] -to [all_registers] -group C2C -name C2C
  path_group -from [all_registers] -to [all_outputs] -group C2O -name C2O
  path_group -from [all_inputs]  -to [all_registers] -group I2C -name I2C
}

define_cost_group -name I2O -design $DESIGN
path_group -from [all_inputs]  -to [all_outputs] -group I2O -name I2O
foreach cg [vfind / -cost_group *] {
  report_timing -group [list $cg] >> $_REPORTS_PATH/${DESIGN}_pretim.rpt
}
#######################################################################################
## Leakage/Dynamic power/Clock Gating setup.
#######################################################################################

#set_db "design:$DESIGN" .lp_clock_gating_cell [vfind /lib* -lib_cell <cg_libcell_name>]
#set_db "design:$DESIGN" .max_leakage_power 0.0 
#set_db "design:$DESIGN" .lp_power_optimization_weight <value from 0 to 1> 
#set_db "design:$DESIGN" .max_dynamic_power <number> 
## read_tcf <TCF file name>
## read_saif <SAIF file name>
## read_vcd <VCD file name>



#### To turn off sequential merging on the design 
#### uncomment & use the following attributes.
##set_db / .optimize_merge_flops false 
##set_db / .optimize_merge_latches false 
#### For a particular instance use attribute 'optimize_merge_seqs' to turn off sequential merging. 



####################################################################################################
## Synthesizing to generic 
####################################################################################################

set_db / .syn_generic_effort $GEN_EFF
syn_generic
puts "Runtime & Memory after 'syn_generic'"
time_info GENERIC
report_dp > $_REPORTS_PATH/generic/${DESIGN}_datapath.rpt
write_snapshot -outdir $_REPORTS_PATH -tag generic
report_summary -directory $_REPORTS_PATH


#### Build RTL power models
##build_rtl_power_models -design $DESIGN -clean_up_netlist [-clock_gating_logic] [-relative <hierarchical instance>]
#report power -rtl



####################################################################################################
## Synthesizing to gates
####################################################################################################


set_db / .syn_map_effort $MAP_OPT_EFF
syn_map
puts "Runtime & Memory after 'syn_map'"
time_info MAPPED
write_snapshot -outdir $_REPORTS_PATH -tag map
report_summary -directory $_REPORTS_PATH
report_dp > $_REPORTS_PATH/map/${DESIGN}_datapath.rpt


foreach cg [vfind / -cost_group *] {
  report_timing -group [list $cg] > $_REPORTS_PATH/${DESIGN}_[vbasename $cg]_post_map.rpt
}


write_do_lec -revised_design fv_map -logfile ${_LOG_PATH}/rtl2intermediate.lec.log > ${_OUTPUTS_PATH}/rtl2intermediate.lec.do

## ungroup -threshold <value>

#######################################################################################################
## Optimize Netlist
#######################################################################################################

## Uncomment to remove assigns & insert tiehilo cells during Incremental synthesis
##set_db / .remove_assigns true 
##set_remove_assign_options -buffer_or_inverter <libcell> -design <design|subdesign> 
##set_db / .use_tiehilo_for_const <none|duplicate|unique> 
set_db / .syn_opt_effort $MAP_OPT_EFF
syn_opt
write_snapshot -outdir $_REPORTS_PATH -tag syn_opt
report_summary -directory $_REPORTS_PATH

puts "Runtime & Memory after 'syn_opt'"
time_info OPT

foreach cg [vfind / -cost_group *] {
  report_timing -group [list $cg] > $_REPORTS_PATH/${DESIGN}_[vbasename $cg]_post_opt.rpt
}



######################################################################################################
## write backend file set (verilog, SDC, config, etc.)
######################################################################################################



report_clock_gating > $_REPORTS_PATH/${DESIGN}_clockgating.rpt
report_power -depth 0 > $_REPORTS_PATH/${DESIGN}_power.rpt
report_gates -power > $_REPORTS_PATH/${DESIGN}_gates_power.rpt

report_dp > $_REPORTS_PATH/${DESIGN}_datapath_incr.rpt
report_messages > $_REPORTS_PATH/${DESIGN}_messages.rpt
write_snapshot -outdir $_REPORTS_PATH -tag final
report_summary -directory $_REPORTS_PATH
write_hdl  > ${_OUTPUTS_PATH}/${DESIGN}_gate.v
write_script > ${_OUTPUTS_PATH}/${DESIGN}.script
write_sdc > ${_OUTPUTS_PATH}/${DESIGN}.sdc


#################################
### write_do_lec
#################################


write_do_lec -golden_design fv_map -revised_design ${_OUTPUTS_PATH}/${DESIGN}_gate.v -logfile  ${_LOG_PATH}/intermediate2final.lec.log > ${_OUTPUTS_PATH}/intermediate2final.lec.do
##Uncomment if the RTL is to be compared with the final netlist..
write_do_lec -revised_design ${_OUTPUTS_PATH}/${DESIGN}_gate.v -logfile ${_LOG_PATH}/rtl2final.lec.log > ${_OUTPUTS_PATH}/rtl2final.lec.do

puts "Final Runtime & Memory."
time_info FINAL
puts "============================"
puts "Synthesis Finished ........."
puts "============================"

file copy [get_db / .stdout_log] ${_LOG_PATH}/.

sh ln -s $_OUTPUTS_PATH outputs
sh ln -s $_REPORTS_PATH reports
sh ln -s $_LOG_PATH logs


quit
