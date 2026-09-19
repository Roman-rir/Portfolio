//`include "environment.sv"
`timescale 1ns/1ps

program test(intf i_ntff);
  environment env;
  

   initial 
    begin
      env = new(i_ntff);
      //cg_h = new();
      //env.gen.repeat_count = 4;
      //env.drv.repeat_count = 4;
      //env.mon.repeat_count = 4;
      //env.scb.repeat_count = 4;
      env.repeat_count = 100;
      env.run();
      //cg_h.sample();
      
    end
  
endprogram
