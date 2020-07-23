///////////////////master_test///////////////////////////////////////    
    
`ifndef master_test_sv
`define master_test_sv

class master_test extends uvm_test;

 `uvm_component_utils(master_test)
  

  
  master_env m_env;
 
  
  master_env_cfg e_cfg; //to set the handle
  
  
  virtual_sequence v_seq;
  
  extern function new(string name="master_test",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration();  
  extern task run_phase(uvm_phase phase);
    
 endclass 
   
  
  function master_test::new(string name="master_test",uvm_component parent);
  super.new(name,parent);
  endfunction
    
 
 function void master_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
  
   
   m_env=master_env::type_id::create("m_env",this);
   e_cfg=master_env_cfg::type_id::create("e_cfg",this);
   
   v_seq=virtual_sequence::type_id::create("v_seq");
   
   uvm_config_db #(master_env_cfg)::set(this,"*","e_cfg",e_cfg);

   
 endfunction
    
    
 function void master_test::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  
 endfunction

 function void master_test::end_of_elaboration();
  //  super.conne(phase);
   uvm_top.print_topology();
 endfunction   
    
     
 task master_test::run_phase(uvm_phase phase);
  // super.run_phase(phase);
   $display("before objection");
  phase.raise_objection(this);
   $display("afetr raising");
 
  
   
   
   v_seq.start(m_env.v_seqr);
   
   
   
   
   phase.drop_objection(this);
   $display("after dropping");
 
 
   phase.phase_done.set_drain_time(this,50);
 endtask
  
    `endif  
///////////////////master_test///////////////////////////////////////    
   
