
`ifndef slave_agent_cfg_sv
`define slave_agent_cfg_sv


class slave_agent_cfg extends uvm_object;
    
  `uvm_object_utils(slave_agent_cfg)
  
  virtual spi_if vif;
  
  uvm_active_passive_enum is_active=UVM_ACTIVE;
  
  bit has_functional_coverage=0;
  
  
   extern function new(string name="slave_agent_cfg");
    
  
endclass
    
     function slave_agent_cfg::new(string name="slave_agent_cfg");
       super.new(name);
    endfunction
    

     `endif
    
  ///////////////////////////slave_agent_cfg////////////////////////////////////////////////      
      
