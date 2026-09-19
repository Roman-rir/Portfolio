//`include "transaction.sv"
//`include "generator.sv"
//`include "driver.sv"
//`include "monitor.sv"
//`include "scoreboard.sv"
//`include "interface.sv"
//timeunit 1ns;
//timeprecision 1ps;


class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard scb;
  coverage cov;
  
  mailbox m1;
  mailbox m2;
  mailbox m3;
  
  virtual intf vif;
  
  int  repeat_count;
  
  function new (virtual intf vif);
    this.vif= vif;
    m1 = new();
    m2 = new();
    m3 = new();
    gen = new(m1);
    drv = new(vif, m1);
    mon = new(vif, m2, m3);
    scb = new(m2);    
    cov = new(m3);

  endfunction
  
     /*
     transaction trans;
      covergroup cg; 
  		coverpoint trans.A;
   		coverpoint trans.B; 
	endgroup
  	*/
  
  	//cg cg_h;
  	
  
  
  task test();
    
    fork
      //cg cg_h;
      //cg_h = new();
      gen.main();
      drv.main();
      mon.main();
      scb.main();
      cov.main();
    join
    
  endtask
  
  int no_transactions = 1;
  
     /*
     transaction trans;
      covergroup cg; 
  		coverpoint trans.A;
   		coverpoint trans.B; 
	endgroup
  	*/
  
  	//cg cg_h;
  
  task run;
    
     begin
        gen.repeat_count = repeat_count;
        drv.repeat_count = repeat_count; 
        mon.repeat_count = repeat_count;
        scb.repeat_count = repeat_count;
        cov.repeat_count = repeat_count;

    	test();
       
       $display("Completed test case %0d",no_transactions);
       no_transactions++; 
     end
    
    $display("Functional Coverage = %0.2f %%",
           cov.cg.get_coverage());
    $display("End of test");
    //cg_h.sample();

    $finish;
  endtask
  
endclass
