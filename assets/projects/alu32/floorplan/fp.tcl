# Example floorplan tcl file for alu32
#
floorPlan -site CoreSite -d 223.56 211.14 10 10 10 10

setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer met5 -stacked_via_bottom_layer met1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VDD VSS} -type core_rings -follow core -layer {top met5 bottom met5 left met5 right met5} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 1.6 bottom 1.6 left 1.6 right 1.6} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None


setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer met5 -stacked_via_bottom_layer met1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {VDD VSS} -layer met4 -direction vertical -width 1.8 -spacing 1.8 -number_of_sets 4 -start_from left -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit met5 -padcore_ring_bottom_layer_limit met1 -block_ring_top_layer_limit met5 -block_ring_bottom_layer_limit met1 -use_wire_group 0 -snap_wire_center_to_grid None

sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { met1(1) met5(5) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 0 -crossoverViaLayerRange { met1(1) met5(5) } -nets { VDD VSS } -allowLayerChange 0 -blockPin useLef -targetViaLayerRange { met1(1) met5(5) }

editPowerVia -skip_via_on_pin Standardcell -bottom_layer met1 -add_vias 1 -top_layer met5


addWellTap -cell FILL4 -cellInterval 60 -prefix WELLTAP


setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit TRACK -spreadDirection clockwise -side Left -layer 3 -spreadType center -spacing 2 -pin {{A_in[0]} {A_in[1]} {A_in[2]} {A_in[3]} {A_in[4]} {A_in[5]} {A_in[6]} {A_in[7]} {A_in[8]} {A_in[9]} {A_in[10]} {A_in[11]} {A_in[12]} {A_in[13]} {A_in[14]} {A_in[15]} {A_in[16]} {A_in[17]} {A_in[18]} {A_in[19]} {A_in[20]} {A_in[21]} {A_in[22]} {A_in[23]} {A_in[24]} {A_in[25]} {A_in[26]} {A_in[27]} {A_in[28]} {A_in[29]} {A_in[30]} {A_in[31]} {ALUCtrl_in[0]} {ALUCtrl_in[1]} {ALUCtrl_in[2]} {B_in[0]} {B_in[1]} {B_in[2]} {B_in[3]} {B_in[4]} {B_in[5]} {B_in[6]} {B_in[7]} {B_in[8]} {B_in[9]} {B_in[10]} {B_in[11]} {B_in[12]} {B_in[13]} {B_in[14]} {B_in[15]} {B_in[16]} {B_in[17]} {B_in[18]} {B_in[19]} {B_in[20]} {B_in[21]} {B_in[22]} {B_in[23]} {B_in[24]} {B_in[25]} {B_in[26]} {B_in[27]} {B_in[28]} {B_in[29]} {B_in[30]} {B_in[31]} {shamt_in[0]} {shamt_in[1]} {shamt_in[2]} {shamt_in[3]} {shamt_in[4]}}
editPin -fixOverlap 1 -unit TRACK -spreadDirection clockwise -side Bottom -layer 2 -spreadType center -spacing 5 -pin {clk reset}
editPin -fixOverlap 1 -unit TRACK -spreadDirection clockwise -side Right -layer 3 -spreadType center -spacing 2 -pin {{Result[0]} {Result[1]} {Result[2]} {Result[3]} {Result[4]} {Result[5]} {Result[6]} {Result[7]} {Result[8]} {Result[9]} {Result[10]} {Result[11]} {Result[12]} {Result[13]} {Result[14]} {Result[15]} {Result[16]} {Result[17]} {Result[18]} {Result[19]} {Result[20]} {Result[21]} {Result[22]} {Result[23]} {Result[24]} {Result[25]} {Result[26]} {Result[27]} {Result[28]} {Result[29]} {Result[30]} {Result[31]} Zero}
setPinAssignMode -pinEditInBatch false
