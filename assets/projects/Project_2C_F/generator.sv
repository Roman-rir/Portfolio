//`include "transaction.sv"

//generator creates new transection 
class generator;
  transaction trans;
  mailbox gen2drv;
  
  int  repeat_count;
 
  
   
  
  function new (mailbox gen2drv);
    this.gen2drv = gen2drv;
       trans = new();
    //cg cg_h = new();
    //cg = new();
   endfunction
  
    

    
    /*
  
 	cg cg_h;
    */
  
  /*
  function new ();
    cg cg_h = new();
  */
  
//timeunit 1ns;
//timeprecision 1ps;

  task main ();
    repeat (repeat_count)
     begin
       trans = new ();
       //cg_h = new ();
          void'(trans.randomize());
       trans.display("Generator");
       gen2drv.put(trans); 
      // cg.sample();
     end
  
  endtask
    
endclass
