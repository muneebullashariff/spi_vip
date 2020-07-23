////////////////////////////////master_agent_top//////////////////////////////////////
    
`ifndef master_agent_top__sv
`define master_agent_top_sv

typedef class master_env_cfg;
    
class master_agent_top extends uvm_component;
  
  `uvm_component_utils(master_agent_top)
  
 
  master_agent m_agent[];
  master_env_cfg e_cfg;
  
  int i=1;
  
  extern function new(string name="master_agent_top",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
      
endclass
  
  
    function master_agent_top:: new(string name="master_agent_top",uvm_component parent);
      super.new(name,parent);
    endfunction

    function void master_agent_top::build_phase(uvm_phase phase);   
      super.build_phase(phase);
      
      if(!uvm_config_db #(master_env_cfg)::get(this,"","e_cfg",e_cfg))
       
        begin
      //  `uvm_fatal(get_type_name(),"unable to get e_cfg handle from test in master_agent_top")
          `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"}); 
          
        end
      
 
      i=e_cfg.no_of_m_agent;
      m_agent=new[i]; 
      
  
      foreach(m_agent[i])
        begin
        
        
          uvm_config_db #(master_agent_cfg)::set(this,$sformatf("m_agent[%0d]",i),"master_agent_cfg",e_cfg.m_cfg[i]);
        
  
          m_agent[i]=master_agent::type_id::create($sformatf("m_agent[%0d]",i),this);    
        
        
        end
  
    
    endfunction
        
    
    `endif
    
 /////////////////////////master_agent_top///////////////////////////////////////////   
    
    
    

