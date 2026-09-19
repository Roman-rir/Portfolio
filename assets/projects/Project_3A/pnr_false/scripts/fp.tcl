# Automatic Floorplan
# No Memory or Macro; standard cells only

puts "It's time to do floorplan; to do automatic floorplan type \"resume\" without the quotes and press enter"
puts "If doing custom floorplan set AUTO_FP=\"off\" bofere you do reusme"
set AUTO_FP "on"

suspend

if { [info exists AUTO_FP] && $AUTO_FP == "on" } {

if { [ info exists FP_BY_DIMENSIONS ]} {
set WIDTH "[expr sqrt([dbGet top.fPlan.area])]"
set HEIGHT "$WIDTH"
set MARGIN "10"

floorPlan -site CoreSite -d $WIDTH $HEIGHT $MARGIN $MARGIN $MARGIN $MARGIN
} else {
set ASPECT_RATIO  1
set INITAL_UTILIZATION 0.6
set MARGIN 10

floorPlan -site CoreSite -r $ASPECT_RATIO $INITAL_UTILIZATION $MARGIN $MARGIN $MARGIN $MARGIN
 }


setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer 5 -stacked_via_bottom_layer 1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VDD VSS} -type core_rings -follow core -layer {top 5 bottom 5 left 5 right 5} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 1.6 bottom 1.6 left 1.6 right 1.6} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None


setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer 5 -stacked_via_bottom_layer 1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {VDD VSS} -layer 4 -direction vertical -width 1.8 -spacing 1.8 -number_of_sets 4 -start_from left -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit 5 -padcore_ring_bottom_layer_limit 1 -block_ring_top_layer_limit 5 -block_ring_bottom_layer_limit 1 -use_wire_group 0 -snap_wire_center_to_grid None

sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { 1(1) 5(5) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 0 -crossoverViaLayerRange { 1(1) 5(5) } -nets { VDD VSS } -allowLayerChange 0 -blockPin useLef -targetViaLayerRange { 1(1) 5(5) }

editPowerVia -skip_via_on_pin Standardcell -bottom_layer 1 -add_vias 1 -top_layer 5


addWellTap -cell FILL4 -cellInterval 60 -prefix WELLTAP


setPinAssignMode -pinEditInBatch true

eval "editPin -fixOverlap 1 -unit TRACK -spreadDirection clockwise -side Left -layer 3 -spreadType center -spacing 2 -pin  {[dbGet [dbGet top.terms.direction input -p].name]}"

#editPin -fixOverlap 1 -unit TRACK -spreadDirection clockwise -side Bottom -layer 2 -spreadType center -spacing 5 -pin {clk reset}

eval "editPin -fixOverlap 1 -unit TRACK -spreadDirection clockwise -side Right -layer 3 -spreadType center -spacing 2 -pin {[dbGet [dbGet top.terms.direction output -p].name]}"

setPinAssignMode -pinEditInBatch false
}
