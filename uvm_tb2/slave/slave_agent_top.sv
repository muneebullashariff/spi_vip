

`ifndef slave_agent_top_sv
`define slave_agent_top_sv


class slave_agent_top extends uvm_component;
  
  `uvm_component_utils(slave_agent_top)
  

 
  slave_agent s_agent[];
  
  master_env_cfg e_cfg; //only 1 handle
  
  int i=1;
  
  extern function new(string name="slave_agent_top",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
      
endclass
  
  
    function slave_agent_top:: new(string name="slave_agent_top",uvm_component parent);
      super.new(name,parent);
    endfunction

    function void slave_agent_top::build_phase(uvm_phase phase);   
      super.build_phase(phase);
   //slave_env_cfg e_cfg;
      
      if(!uvm_config_db #(master_env_cfg)::get(this,"","e_cfg",e_cfg))
       
        begin
      //  `uvm_fatal(get_type_name(),"unable to get e_cfg handle from test in slave_agent_top")
          `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"}); 
          
        end
      
  
      i=e_cfg.no_of_s_agent;
      s_agent=new[i]; 
      foreach(s_agent[i])
        begin
        
        
          uvm_config_db #(slave_agent_cfg)::set(this,$sformatf("s_agent[%0d]",i),"slave_agent_cfg",e_cfg.s_cfg[i]);
  
    
          s_agent[i]=slave_agent::type_id::create($sformatf("s_agent[%0d]",i),this);    
        
        
        end
 
    endfunction
        
    `endif
