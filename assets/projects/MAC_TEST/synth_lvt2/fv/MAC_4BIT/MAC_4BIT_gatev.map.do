
//input ports
add mapped point SYS_CLOCK SYS_CLOCK -type PI PI
add mapped point SRST SRST -type PI PI
add mapped point A[3] A[3] -type PI PI
add mapped point A[2] A[2] -type PI PI
add mapped point A[1] A[1] -type PI PI
add mapped point A[0] A[0] -type PI PI
add mapped point B[3] B[3] -type PI PI
add mapped point B[2] B[2] -type PI PI
add mapped point B[1] B[1] -type PI PI
add mapped point B[0] B[0] -type PI PI

//output ports
add mapped point Y[7] Y[7] -type PO PO
add mapped point Y[6] Y[6] -type PO PO
add mapped point Y[5] Y[5] -type PO PO
add mapped point Y[4] Y[4] -type PO PO
add mapped point Y[3] Y[3] -type PO PO
add mapped point Y[2] Y[2] -type PO PO
add mapped point Y[1] Y[1] -type PO PO
add mapped point Y[0] Y[0] -type PO PO

//inout ports




//Sequential Pins
add mapped point Y[6]/q Y_reg[6]/Q -type DFF DFF
add mapped point Y[1]/q Y_reg[1]/Q -type DFF DFF
add mapped point Y[0]/q Y_reg[0]/Q -type DFF DFF
add mapped point Y[7]/q Y_reg[7]/Q -type DFF DFF
add mapped point Y[4]/q Y_reg[4]/Q -type DFF DFF
add mapped point Y[3]/q Y_reg[3]/Q -type DFF DFF
add mapped point Y[2]/q Y_reg[2]/Q -type DFF DFF
add mapped point Y[5]/q Y_reg[5]/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
