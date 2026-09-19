
//input ports
add mapped point SYS_CLOCK SYS_CLOCK -type PI PI
add mapped point SRST SRST -type PI PI
add mapped point X0[3] X0[3] -type PI PI
add mapped point X0[2] X0[2] -type PI PI
add mapped point X0[1] X0[1] -type PI PI
add mapped point X0[0] X0[0] -type PI PI
add mapped point X1[3] X1[3] -type PI PI
add mapped point X1[2] X1[2] -type PI PI
add mapped point X1[1] X1[1] -type PI PI
add mapped point X1[0] X1[0] -type PI PI
add mapped point X2[3] X2[3] -type PI PI
add mapped point X2[2] X2[2] -type PI PI
add mapped point X2[1] X2[1] -type PI PI
add mapped point X2[0] X2[0] -type PI PI
add mapped point X3[3] X3[3] -type PI PI
add mapped point X3[2] X3[2] -type PI PI
add mapped point X3[1] X3[1] -type PI PI
add mapped point X3[0] X3[0] -type PI PI
add mapped point C0[3] C0[3] -type PI PI
add mapped point C0[2] C0[2] -type PI PI
add mapped point C0[1] C0[1] -type PI PI
add mapped point C0[0] C0[0] -type PI PI
add mapped point C1[3] C1[3] -type PI PI
add mapped point C1[2] C1[2] -type PI PI
add mapped point C1[1] C1[1] -type PI PI
add mapped point C1[0] C1[0] -type PI PI
add mapped point C2[3] C2[3] -type PI PI
add mapped point C2[2] C2[2] -type PI PI
add mapped point C2[1] C2[1] -type PI PI
add mapped point C2[0] C2[0] -type PI PI
add mapped point C3[3] C3[3] -type PI PI
add mapped point C3[2] C3[2] -type PI PI
add mapped point C3[1] C3[1] -type PI PI
add mapped point C3[0] C3[0] -type PI PI

//output ports
add mapped point Y[9] Y[9] -type PO PO
add mapped point Y[8] Y[8] -type PO PO
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
add mapped point Y[9]/q Y_reg[9]/Q -type DFF DFF
add mapped point Y[8]/q Y_reg[8]/Q -type DFF DFF
add mapped point Y[6]/q Y_reg[6]/Q -type DFF DFF
add mapped point Y[2]/q Y_reg[2]/Q -type DFF DFF
add mapped point Y[1]/q Y_reg[1]/Q -type DFF DFF
add mapped point Y[5]/q Y_reg[5]/Q -type DFF DFF
add mapped point Y[0]/q Y_reg[0]/Q -type DFF DFF
add mapped point Y[7]/q Y_reg[7]/Q -type DFF DFF
add mapped point Y[4]/q Y_reg[4]/Q -type DFF DFF
add mapped point Y[3]/q Y_reg[3]/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
