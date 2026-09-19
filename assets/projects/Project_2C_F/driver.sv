//`include "transaction.sv"


class driver;
  virtual intf vif;
  mailbox gen2drv;
  
  int  repeat_count;
  int no_transactions;
  
  function new (virtual intf vif, mailbox gen2drv);
    this.vif = vif;
    this.gen2drv = gen2drv;
  endfunction
  
 //timeunit 1ns;
//timeprecision 1ps;
 
  task main ();
    repeat (repeat_count)
      
     begin
       transaction trans;
       gen2drv.get(trans); 
  
        @(posedge vif.SYS_CLOCK);
       vif.A = trans.A;
       vif.B = trans.B;
       //vif.SRST <= trans.SRST;
		#1;
       trans.display("Driver");
       no_transactions++;   
       $display("No of Transactions %0d",no_transactions);
       $display("DRIVER SET A=%0d B=%0d @ %0t",
          trans.A, trans.B, $time);
     end
  
  endtask
    
endclass
