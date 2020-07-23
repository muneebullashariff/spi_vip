//////////////////////////////////master_agent_cfg///////////////////////////////////////////
    
`ifndef master_agent_cfg_sv
`define master_agent_cfg_sv

 class master_agent_cfg extends uvm_object;
    
  `uvm_object_utils(master_agent_cfg)
  
  virtual spi_if vif;
  
  uvm_active_passive_enum is_active=UVM_ACTIVE;
  
  bit has_functional_coverage=0;
  
  
   extern function new(string name="master_agent_cfg");
    
  
endclass
    
     function master_agent_cfg::new(string name="master_agent_cfg");
       super.new(name);
    endfunction
    

    
    
     `endif ///////////////////////////master_agent_cfg////////////////////////////////////////////////      
     
