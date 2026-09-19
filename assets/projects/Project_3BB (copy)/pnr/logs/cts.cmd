#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sat Jun 27 01:44:01 2026                
#                                                     
#######################################################

#@(#)CDS: Innovus v21.18-s099_1 (64bit) 07/18/2023 13:03 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 21.18-s099_1 NR230707-1955/21_18-UB (database version 18.20.605) {superthreading v2.17}
#@(#)CDS: AAE 21.18-s017 (64bit) 07/18/2023 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 21.18-s022_1 () Jul 11 2023 23:10:24 ( )
#@(#)CDS: SYNTECH 21.18-s010_1 () Jul  5 2023 06:32:03 ( )
#@(#)CDS: CPE v21.18-s053
#@(#)CDS: IQuantus/TQuantus 21.1.1-s966 (64bit) Wed Mar 8 10:22:20 PST 2023 (Linux 3.10.0-693.el7.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getVersion
define_proc_arguments ViaFillQor -info {This procedure extracts Viafill details from innovus db} -define_args {
		{-window "window coordinates" "" list optional}
		{-window_size "window size in microns" "" string optional}
	
	}
define_proc_arguments ProcessFills -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
				{-csvName "File path for Fill Data csv file" "Path of CSV file" string required}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list required}
    {-output_data "Boolean Flag to output Fill Data for further processing" "" string required}
}
define_proc_arguments FillQor -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list optional}
				{-outData "Boolean Flag to output Fill Data for further processing" "" boolean optional}
    {-outDataFile "File path for Fill Data csv file" "Path of CSV file" string optional}
}
define_proc_arguments ProcessFills_fast -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
				{-csvName "File path for Fill Data csv file" "Path of CSV file" string required}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list required}
    {-output_data "Boolean Flag to output Fill Data for further processing" "" string required}
}
define_proc_arguments FillQor_fast -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list optional}
				{-outData "Boolean Flag to output Fill Data for further processing" "" boolean optional}
    {-outDataFile "File path for Fill Data csv file" "Path of CSV file" string optional}
}
define_proc_arguments ProcessFills_fast_stampOnly -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
	
}
define_proc_arguments FillQor_fast_stampOnly -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
}
setAnalysisMode -analysisType onChipVariation
restoreDesign DBS/place.enc.dat RISC_V3_PIPELINED_TOP
set_ccopt_property buffer_cells { CLKBUFX4 CLKBUFX8 CLKBUFX2 }
set_ccopt_property inverter_cells { CLKINVX2 CLKINVX8 CLKINVX1 CLKINVX4 }
ccopt_design
win
gui_select -rect {31.12300 8.66100 30.04500 4.25100}
zoomBox -25.16100 -10.56700 151.80300 67.94200
zoomBox 2.67600 -5.00000 95.05400 35.98300
zoomBox 7.26100 -4.11300 85.78400 30.72300
zoomBox -9.16600 -7.19600 118.69600 49.52900
zoomBox -29.28800 -10.24800 121.13700 56.48700
zoomBox -115.11200 -22.94600 129.82900 85.72000
zoomBox -94.07500 -17.31400 114.12500 75.05200
zoomBox -76.19300 -12.52700 100.77700 65.98400
zoomBox -60.99300 -8.45900 89.43100 58.27600
zoomBox -48.07500 -5.00000 79.78700 51.72500
zoomBox -37.09300 -2.06000 71.59000 46.15600
zoomBox -27.75900 0.43900 64.62200 41.42300
zoomBox -27.75900 16.83100 64.62200 57.81500
zoomBox -36.25600 14.05200 72.42800 62.26900
zoomBox -59.44300 7.80400 90.98500 74.54000
zoomBox -81.51300 5.65000 95.46100 84.16300
zoomBox -138.02600 0.13300 106.92300 108.80300
zoomBox -172.95000 -2.82900 115.22500 125.01800
zoomBox -172.95000 9.95600 115.22500 137.80300
zoomBox -172.95000 22.74100 115.22500 150.58800
zoomBox -368.54100 -15.95200 183.51600 228.96400
zoomBox -308.95500 -11.24800 160.29400 196.93100
zoomBox -214.43400 -7.60800 124.60000 142.80200
zoomBox -119.47200 -3.95200 88.73900 88.41900
zoomBox -77.37500 -2.44100 73.05700 64.29700
zoomBox -60.97600 -2.11600 66.89300 54.61200
zoomBox -47.03600 -1.83900 61.65300 46.38000
zoomBox -35.18700 -1.60400 57.19900 39.38200
zoomBox -10.14600 0.93400 46.59100 26.10500
zoomBox 0.91200 2.05500 41.90700 20.24200
zoomBox -2.23900 0.41700 45.99100 21.81400
zoomBox -10.54100 -3.83300 56.21400 25.78200
zoomBox -22.53300 -9.34700 69.86100 31.64300
zoomBox -31.12000 -12.92000 77.58000 35.30400
zoomBox -41.39500 -17.08900 86.48900 39.64600
zoomBox -53.54500 -21.95300 96.90900 44.79500
zoomBox -39.01600 -14.20000 88.87100 42.53600
zoomBox 1.50200 4.88100 68.26100 34.49800
zoomBox 22.92700 14.01200 57.77700 29.47300
zoomBox 34.11600 18.74400 52.30900 26.81500
zoomBox 37.50700 20.17700 50.65200 26.00900
zoomBox 38.83100 20.73700 50.00500 25.69400
selectPhyPin 47.0400 22.7800 47.8400 23.0800 3 {IR1[4]}
gui_select -rect {44.23200 22.42900 45.94400 22.68100}
deselectAll
selectPhyPin 47.0400 22.7800 47.8400 23.0800 3 {IR1[4]}
zoomBox 36.45800 19.95100 51.92500 26.81300
zoomBox 33.65300 17.92600 58.84000 29.10000
zoomBox 29.69900 14.41500 70.71400 32.61100
zoomBox 25.30100 10.99900 82.07000 36.18400
zoomBox 19.09600 6.27900 97.67000 41.13800
zoomBox 3.79800 -3.45600 131.74400 53.30600
zoomBox -3.83700 -7.71100 146.68800 59.06800
zoomBox -3.49100 -3.19100 124.45500 53.57100
zoomBox -3.19700 0.65100 105.55700 48.89900
zoomBox -2.73400 6.69200 75.84000 41.55100
zoomBox -2.55400 9.05100 64.23600 38.68200
zoomBox 3.99500 11.27300 60.76800 36.46000
zoomBox 9.56200 13.16200 57.81900 34.57100
deselectAll
gui_select -rect {38.23800 24.17100 39.32600 24.12800}
gui_select -rect {38.28100 24.17100 39.32600 23.99700}
zoomBox 21.06300 17.30900 50.70200 30.45800
zoomBox 23.80800 18.29900 49.00200 29.47600
zoomBox 28.10600 19.85500 46.31000 27.93100
gui_select -rect {38.20100 24.20500 38.61100 24.12300}
selectVia 37.9950 23.9850 38.3650 24.3150 3 n_12
deselectAll
selectVia 37.9950 23.9850 38.3650 24.3150 3 n_12
gui_select -rect {38.23400 24.17200 39.43200 24.04100}
deselectAll
zoomBox 26.08400 19.22100 47.50000 28.72200
zoomBox 23.70500 18.47400 48.90100 29.65200
zoomBox 21.21300 16.77700 56.08800 32.24900
zoomBox 16.50400 13.32400 73.29100 38.51700
zoomBox 14.10900 11.73300 80.91800 41.37200
zoomBox 11.21700 9.89300 89.81600 44.76300
zoomBox 2.57200 5.61900 111.36100 53.88200
zoomBox -4.19700 3.69700 123.79000 60.47800
zoomBox -12.52800 1.64000 138.04600 68.44100
zoomBox -11.51000 2.31200 116.47800 59.09300
zoomBox -10.64500 2.88300 98.14500 51.14700
zoomBox -9.90900 3.36900 82.56200 44.39300
zoomBox -8.52200 4.20100 58.29000 33.84200
zoomBox -5.93100 8.68100 42.34100 30.09700
zoomBox -9.28200 7.27500 47.51100 32.47100
zoomBox -17.85800 3.65600 60.74800 38.52900
zoomBox -14.87000 6.78200 51.94500 36.42400
zoomBox -12.33100 9.43900 44.46200 34.63500
zoomBox -10.17300 11.69700 38.10200 33.11400
zoomBox -8.33800 13.61700 32.69600 31.82100
zoomBox -5.39200 16.53300 24.25600 29.68600
zoomBox -4.24100 17.67200 20.96000 28.85200
zoomBox -5.49600 16.66600 24.15200 29.81900
zoomBox -12.15100 12.95700 36.12700 34.37500
zoomBox -16.08400 11.63500 40.71300 36.83300
zoomBox -22.03300 10.29700 44.78900 39.94200
zoomBox -29.37100 8.75500 49.24400 43.63200
zoomBox -39.10400 7.24100 53.38500 48.27300
zoomBox -54.24800 6.38700 54.56200 54.66000
