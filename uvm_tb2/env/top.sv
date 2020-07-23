
import uvm_pkg::*;
`include "uvm_macros.svh"

`include "spi_if.sv"
`include "master_trans.sv"
`include "master_seq.sv"
`include "master_seqr.sv"
`include "master_drv.sv"
`include "master_mon.sv"
`include "master_agent_cfg.sv"
`include "master_agent.sv"
`include "master_agent_top.sv"

`include "slave_trans.sv"
`include "slave_seq.sv"
`include "slave_seqr.sv"
`include "slave_drv.sv"
`include "slave_mon.sv"
`include "slave_agent_cfg.sv"
`include "slave_agent.sv"
`include "slave_agent_top.sv"

`include "master_sb.sv"
`include "master_env_cfg.sv"

`include "virtual_sequencer.sv"
`include "virtual_sequence.sv"
`include "master_env.sv"

`include "master_test.sv"



module tb_top();

  bit clk;
  bit reset;
  
  
  initial
    clk=1'b0;
  always #5 clk=~clk;
  
  
  spi_if if_inst ();
  
  
  initial
    begin
      uvm_config_db #(virtual spi_if)::set(null,"*","vif",if_inst);
     
      run_test("master_test");
  
    end
  
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
      
    //  #50 $finish();
    end
 /* 
  initial
    begin
      
      run_test();
      
    end
  */
  
  
endmodule  
   
     
     
   


