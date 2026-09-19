module PROCESSOR_V3_PIPELINED
(input  logic        SYS_CLOCK, RST,
 input  logic [31:0] PM_OUT, DM_OUT,
 output logic [31:0] DM_IN,
 output logic [3:0]  PC, DM_ADDR,
 output logic        DM_WR,
 output logic [31:0] IR1, IR2, ACCUM_R,
 output logic [2:0]  PSTATE);

logic [31:0] ALU_OUT;
logic [3:0]  next_PC, next_DM_ADDR;
logic [3:0]  IR1_TYPE, IR1_OPCODE, IR1_RD, IR1_RS1, IR1_RS2, IR1_BDIR;
logic [3:0]  IR2_TYPE, IR2_OPCODE, IR2_RD, IR2_RS1, IR2_RS2, IR2_BDIR;
logic [31:0] IR1_IMM,  IR2_IMM;
logic [31:0] RF_Q1, RF_Q2;
logic [31:0] RF_IN;
logic [31:0] next_IR1, next_IR2;
logic [31:0] next_ACCUM_R;
logic        RF_WR;
logic [31:0] RF [15:0];
logic [2:0]  NSTATE;
logic [3:0]  RF_WR_ADDR;

assign IR1_TYPE   = IR1[31:28];
assign IR1_OPCODE = IR1[27:24];
assign IR1_RD     = IR1[23:20];
assign IR1_RS1    = IR1[19:16];
assign IR1_RS2    = IR1[15:12];
assign IR1_BDIR   = IR1[11:8];
assign IR1_IMM    = {{24{1'b0}}, IR1[7:0]};

assign IR2_TYPE   = IR2[31:28];

// forwarding and hazard logic
logic IR2_produces_RF;
assign IR2_produces_RF = (IR2_TYPE == 4'd0) || (IR2_TYPE == 4'd1);

logic fwd_RS1, fwd_RS2;
assign fwd_RS1 = IR2_produces_RF && (IR2_RD == IR1_RS1) && (IR2_RD != 4'd0);
assign fwd_RS2 = IR2_produces_RF && (IR2_RD == IR1_RS2) && (IR2_RD != 4'd0);

assign RF_Q1 = fwd_RS1 ? ACCUM_R : RF[IR1_RS1];
assign RF_Q2 = fwd_RS2 ? ACCUM_R : RF[IR1_RS2];

always_comb
begin
    NSTATE = 'x;
    case (PSTATE)
        0: NSTATE = 1;
        1: NSTATE = 2;
        2: begin
               if      (IR1_TYPE == 4'd0 || IR1_TYPE == 4'd1) NSTATE = 3;
               else if (IR1_TYPE == 4'd2)                      NSTATE = 4;
               else if (IR1_TYPE == 4'd3)                      NSTATE = 5;
               else                                            NSTATE = 1;
           end
        3: begin
               if      (IR1_TYPE == 4'd0 || IR1_TYPE == 4'd1) NSTATE = 3;
               else if (IR1_TYPE == 4'd2)                      NSTATE = 4;
               else if (IR1_TYPE == 4'd3)                      NSTATE = 5;
               else                                            NSTATE = 1;
           end
        4: begin
               if      (IR1_TYPE == 4'd0 || IR1_TYPE == 4'd1) NSTATE = 3;
               else if (IR1_TYPE == 4'd2)                      NSTATE = 4;
               else if (IR1_TYPE == 4'd3)                      NSTATE = 5;
               else                                            NSTATE = 1;
           end
        5: begin
               if      (IR1_TYPE == 4'd0 || IR1_TYPE == 4'd1) NSTATE = 3;
               else if (IR1_TYPE == 4'd2)                      NSTATE = 4;
               else if (IR1_TYPE == 4'd3)                      NSTATE = 5;
               else                                            NSTATE = 1;
           end
        default: NSTATE = '0;
    endcase

    {ALU_OUT, DM_WR, RF_WR} = '0;
    RF_IN        = '0;
    DM_IN        = 'x;
    next_PC      = PC;
    next_DM_ADDR = DM_ADDR;
    next_IR1     = IR1;
    next_IR2     = IR2;
    next_ACCUM_R = ACCUM_R;
    RF_WR_ADDR   = IR2_RD;

    case (PSTATE)

        0: begin
               next_PC  = '0;
               next_IR1 = '0;
               next_IR2 = '0;
           end

        1: begin
               next_PC  = PC + 1;
               next_IR1 = PM_OUT;
               next_IR2 = IR1;
           end

        2: begin
               next_PC  = PC + 1;
               next_IR1 = PM_OUT;
               next_IR2 = IR1;	
			   
			   
			   
                 case (IR2_TYPE)
                        0, 1: begin
                                  RF_WR      = 1;
                                  RF_WR_ADDR = IR2_RD;
                                  RF_IN      = ACCUM_R;
                              end
                           2: begin
                                  RF_WR      = 1;
                                  RF_WR_ADDR = IR2_RD;
                                  RF_IN      = DM_OUT;
                              end
                           3: begin
                                  DM_WR = 1;
                                  DM_IN = RF[IR2_RD];
                              end
                     default: ;
                 endcase

			   
			   
			   
			   

               case (IR1_TYPE)
                   0: begin
                          case (IR1_OPCODE)
                              0:  ALU_OUT = RF_Q1 + RF_Q2;
                              1:  ALU_OUT = RF_Q1 - RF_Q2;
                              2:  ALU_OUT = RF_Q2 + 1;
                              3:  ALU_OUT = RF_Q2 - 1;
                              4:  ALU_OUT = '0;
                              5:  ALU_OUT = ~RF_Q2;
                              6:  ALU_OUT = {{16{1'b0}}, RF_Q2[15:0]};
                              7:  ALU_OUT = RF_Q2;
                              8:  ALU_OUT = RF_Q1 & RF_Q2;
                              9:  ALU_OUT = RF_Q1 | RF_Q2;
                              10: ALU_OUT = RF_Q1 ^ RF_Q2;
                              11: ALU_OUT = ~(RF_Q1 & RF_Q2);
                              12: ALU_OUT = ~(RF_Q1 | RF_Q2);
                              13: ALU_OUT = ~(RF_Q1 ^ RF_Q2);
                              14: ALU_OUT = RF_Q1 << 1;
                              15: ALU_OUT = RF_Q1 >> 1;
                              default: ALU_OUT = 'x;
                          endcase
                          next_ACCUM_R = ALU_OUT;
                      end

                   1: begin
                          case (IR1_OPCODE)
                              0:  ALU_OUT = RF_Q1 + IR1_IMM;
                              1:  ALU_OUT = RF_Q1 - IR1_IMM;
                              2:  ALU_OUT = IR1_IMM + 1;
                              3:  ALU_OUT = IR1_IMM - 1;
                              4:  ALU_OUT = '0;
                              5:  ALU_OUT = ~IR1_IMM;
                              6:  ALU_OUT = {{16{1'b0}}, IR1_IMM[15:0]};
                              7:  ALU_OUT = IR1_IMM;
                              8:  ALU_OUT = RF_Q1 & IR1_IMM;
                              9:  ALU_OUT = RF_Q1 | IR1_IMM;
                              10: ALU_OUT = RF_Q1 ^ IR1_IMM;
                              11: ALU_OUT = ~(RF_Q1 & IR1_IMM);
                              12: ALU_OUT = ~(RF_Q1 | IR1_IMM);
                              13: ALU_OUT = ~(RF_Q1 ^ IR1_IMM);
                              14: ALU_OUT = RF_Q1 << 1;
                              15: ALU_OUT = RF_Q1 >> 1;
                              default: ALU_OUT = 'x;
                          endcase
                          next_ACCUM_R = ALU_OUT; 
                      end

                   2, 3: begin
                              ALU_OUT      = RF_Q1 + RF_Q2;
                              next_DM_ADDR = ALU_OUT[3:0]; 
                          end

                   default: ;
               endcase
           end

        3: begin
               next_PC  = PC + 1;
               next_IR1 = PM_OUT;
               next_IR2 = IR1;

               	  case (IR2_TYPE)
                        0, 1: begin
                                  RF_WR      = 1;
                                  RF_WR_ADDR = IR2_RD;
                                  RF_IN      = ACCUM_R;
                              end
                           2: begin
                                  RF_WR      = 1;
                                  RF_WR_ADDR = IR2_RD;
                                  RF_IN      = DM_OUT;
                              end
                           3: begin
                                  DM_WR = 1;
                                  DM_IN = RF[IR2_RD];
                              end
                     default: ;
            endcase


           
               case (IR1_TYPE)
                   0: begin
                          case (IR1_OPCODE)
                              0:  ALU_OUT = RF_Q1 + RF_Q2;
                              1:  ALU_OUT = RF_Q1 - RF_Q2;
                              2:  ALU_OUT = RF_Q2 + 1;
                              3:  ALU_OUT = RF_Q2 - 1;
                              4:  ALU_OUT = '0;
                              5:  ALU_OUT = ~RF_Q2;
                              6:  ALU_OUT = {{16{1'b0}}, RF_Q2[15:0]};
                              7:  ALU_OUT = RF_Q2;
                              8:  ALU_OUT = RF_Q1 & RF_Q2;
                              9:  ALU_OUT = RF_Q1 | RF_Q2;
                              10: ALU_OUT = RF_Q1 ^ RF_Q2;
                              11: ALU_OUT = ~(RF_Q1 & RF_Q2);
                              12: ALU_OUT = ~(RF_Q1 | RF_Q2);
                              13: ALU_OUT = ~(RF_Q1 ^ RF_Q2);
                              14: ALU_OUT = RF_Q1 << 1;
                              15: ALU_OUT = RF_Q1 >> 1;
                              default: ALU_OUT = 'x;
                          endcase
                          next_ACCUM_R = ALU_OUT; 
                      end

                   1: begin
                          case (IR1_OPCODE)
                              0:  ALU_OUT = RF_Q1 + IR1_IMM;
                              1:  ALU_OUT = RF_Q1 - IR1_IMM;
                              2:  ALU_OUT = IR1_IMM + 1;
                              3:  ALU_OUT = IR1_IMM - 1;
                              4:  ALU_OUT = '0;
                              5:  ALU_OUT = ~IR1_IMM;
                              6:  ALU_OUT = {{16{1'b0}}, IR1_IMM[15:0]};
                              7:  ALU_OUT = IR1_IMM;
                              8:  ALU_OUT = RF_Q1 & IR1_IMM;
                              9:  ALU_OUT = RF_Q1 | IR1_IMM;
                              10: ALU_OUT = RF_Q1 ^ IR1_IMM;
                              11: ALU_OUT = ~(RF_Q1 & IR1_IMM);
                              12: ALU_OUT = ~(RF_Q1 | IR1_IMM);
                              13: ALU_OUT = ~(RF_Q1 ^ IR1_IMM);
                              14: ALU_OUT = RF_Q1 << 1;
                              15: ALU_OUT = RF_Q1 >> 1;
                              default: ALU_OUT = 'x;
                          endcase
                          next_ACCUM_R = ALU_OUT; 
                      end

                   2, 3: begin
                              ALU_OUT      = RF_Q1 + RF_Q2;
                              next_DM_ADDR = ALU_OUT[3:0]; 
                          end

                   default: ;
               endcase
           end

        4: begin
               next_PC  = PC + 1;
               next_IR1 = PM_OUT;
               next_IR2 = IR1;

              
            case (IR2_TYPE)
                        0, 1: begin
                                  RF_WR      = 1;
                                  RF_WR_ADDR = IR2_RD;
                                  RF_IN      = ACCUM_R;
                              end
                           2: begin
                                  RF_WR      = 1;
                                  RF_WR_ADDR = IR2_RD;
                                  RF_IN      = DM_OUT;
                              end
                           3: begin
                                  DM_WR = 1;
                                  DM_IN = RF[IR2_RD];
                              end
                     default: ;
            endcase

               // IR1 execution
               case (IR1_TYPE)
                   0: begin
                          case (IR1_OPCODE)
                              0:  ALU_OUT = RF_Q1 + RF_Q2;
                              1:  ALU_OUT = RF_Q1 - RF_Q2;
                              2:  ALU_OUT = RF_Q2 + 1;
                              3:  ALU_OUT = RF_Q2 - 1;
                              4:  ALU_OUT = '0;
                              5:  ALU_OUT = ~RF_Q2;
                              6:  ALU_OUT = {{16{1'b0}}, RF_Q2[15:0]};
                              7:  ALU_OUT = RF_Q2;
                              8:  ALU_OUT = RF_Q1 & RF_Q2;
                              9:  ALU_OUT = RF_Q1 | RF_Q2;
                              10: ALU_OUT = RF_Q1 ^ RF_Q2;
                              11: ALU_OUT = ~(RF_Q1 & RF_Q2);
                              12: ALU_OUT = ~(RF_Q1 | RF_Q2);
                              13: ALU_OUT = ~(RF_Q1 ^ RF_Q2);
                              14: ALU_OUT = RF_Q1 << 1;
                              15: ALU_OUT = RF_Q1 >> 1;
                              default: ALU_OUT = 'x;
                          endcase
                          next_ACCUM_R = ALU_OUT;
                      end

                   1: begin
                          case (IR1_OPCODE)
                              0:  ALU_OUT = RF_Q1 + IR1_IMM;
                              1:  ALU_OUT = RF_Q1 - IR1_IMM;
                              2:  ALU_OUT = IR1_IMM + 1;
                              3:  ALU_OUT = IR1_IMM - 1;
                              4:  ALU_OUT = '0;
                              5:  ALU_OUT = ~IR1_IMM;
                              6:  ALU_OUT = {{16{1'b0}}, IR1_IMM[15:0]};
                              7:  ALU_OUT = IR1_IMM;
                              8:  ALU_OUT = RF_Q1 & IR1_IMM;
                              9:  ALU_OUT = RF_Q1 | IR1_IMM;
                              10: ALU_OUT = RF_Q1 ^ IR1_IMM;
                              11: ALU_OUT = ~(RF_Q1 & IR1_IMM);
                              12: ALU_OUT = ~(RF_Q1 | IR1_IMM);
                              13: ALU_OUT = ~(RF_Q1 ^ IR1_IMM);
                              14: ALU_OUT = RF_Q1 << 1;
                              15: ALU_OUT = RF_Q1 >> 1;
                              default: ALU_OUT = 'x;
                          endcase
                          next_ACCUM_R = ALU_OUT; 
                      end

                   2, 3: begin
                              ALU_OUT      = RF_Q1 + RF_Q2;
                              next_DM_ADDR = ALU_OUT[3:0]; 
                          end

                   default: ;
               endcase
           end
		   
		   
        5: begin
               next_PC  = PC + 1;
               next_IR1 = PM_OUT;
               next_IR2 = IR1;

              
                 case (IR2_TYPE)
                        0, 1: begin
                                  RF_WR      = 1;
                                  RF_WR_ADDR = IR2_RD;
                                  RF_IN      = ACCUM_R;
                              end
                           2: begin
                                  RF_WR      = 1;
                                  RF_WR_ADDR = IR2_RD;
                                  RF_IN      = DM_OUT;
                              end
                           3: begin
                                  DM_WR = 1;
                                  DM_IN = RF[IR2_RD];
                              end
                     default: ;
            endcase


               
               case (IR1_TYPE)
                   0: begin
                          case (IR1_OPCODE)
                              0:  ALU_OUT = RF_Q1 + RF_Q2;
                              1:  ALU_OUT = RF_Q1 - RF_Q2;
                              2:  ALU_OUT = RF_Q2 + 1;
                              3:  ALU_OUT = RF_Q2 - 1;
                              4:  ALU_OUT = '0;
                              5:  ALU_OUT = ~RF_Q2;
                              6:  ALU_OUT = {{16{1'b0}}, RF_Q2[15:0]};
                              7:  ALU_OUT = RF_Q2;
                              8:  ALU_OUT = RF_Q1 & RF_Q2;
                              9:  ALU_OUT = RF_Q1 | RF_Q2;
                              10: ALU_OUT = RF_Q1 ^ RF_Q2;
                              11: ALU_OUT = ~(RF_Q1 & RF_Q2);
                              12: ALU_OUT = ~(RF_Q1 | RF_Q2);
                              13: ALU_OUT = ~(RF_Q1 ^ RF_Q2);
                              14: ALU_OUT = RF_Q1 << 1;
                              15: ALU_OUT = RF_Q1 >> 1;
                              default: ALU_OUT = 'x;
                          endcase
                          next_ACCUM_R = ALU_OUT;
                      end

                   1: begin
                          case (IR1_OPCODE)
                              0:  ALU_OUT = RF_Q1 + IR1_IMM;
                              1:  ALU_OUT = RF_Q1 - IR1_IMM;
                              2:  ALU_OUT = IR1_IMM + 1;
                              3:  ALU_OUT = IR1_IMM - 1;
                              4:  ALU_OUT = '0;
                              5:  ALU_OUT = ~IR1_IMM;
                              6:  ALU_OUT = {{16{1'b0}}, IR1_IMM[15:0]};
                              7:  ALU_OUT = IR1_IMM;
                              8:  ALU_OUT = RF_Q1 & IR1_IMM;
                              9:  ALU_OUT = RF_Q1 | IR1_IMM;
                              10: ALU_OUT = RF_Q1 ^ IR1_IMM;
                              11: ALU_OUT = ~(RF_Q1 & IR1_IMM);
                              12: ALU_OUT = ~(RF_Q1 | IR1_IMM);
                              13: ALU_OUT = ~(RF_Q1 ^ IR1_IMM);
                              14: ALU_OUT = RF_Q1 << 1;
                              15: ALU_OUT = RF_Q1 >> 1;
                              default: ALU_OUT = 'x;
                          endcase
                          next_ACCUM_R = ALU_OUT;
                      end

                   2, 3: begin
                              ALU_OUT      = RF_Q1 + RF_Q2;
                              next_DM_ADDR = ALU_OUT[3:0];
                          end

                   default: ;
               endcase
           end

        default: ;
    endcase
end

always_ff @(posedge SYS_CLOCK)
begin
    if (RST) begin
        PSTATE  <= 3'd0;
        PC      <= 4'd0;
        DM_ADDR <= 4'd0;
        IR1     <= '0;
        IR2     <= '0;
        ACCUM_R <= '0;
        for (int i = 0; i <= 15; i = i+1)
            RF[i] <= i;
    end
    else begin
        PSTATE  <= NSTATE;
        PC      <= next_PC;
        DM_ADDR <= next_DM_ADDR;
        IR1     <= next_IR1;
        IR2     <= next_IR2;
        ACCUM_R <= next_ACCUM_R;
        if (RF_WR)
            RF[RF_WR_ADDR] <= RF_IN;
    end
end

endmodule
