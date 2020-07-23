///////////////////////////master_env_cfg///////////////////////////////
    
`ifndef master_env_cfg__sv
`define master_env_cfg_sv    
    
class master_env_cfg extends uvm_object;
  
 `uvm_object_utils(master_env_cfg)
  
  
  bit has_scoreboard=1;
  bit has_m_agent=1;
  bit has_s_agent=1;
  bit has_m_top=1;
  bit has_s_top=1;
  
  
  bit has_virtual_sequencer=1;

  master_agent_cfg m_cfg[]; //config_object is dynamic,as config for particular agent might change
  
  slave_agent_cfg s_cfg[];
  
  
  
  //These are the flexible parameters,when declared can be reused accordingly
  int no_of_scoreboard=1;
  int no_of_m_agent=1;
  int no_of_s_agent=1;
  int no_of_m_top=1;
  int no_of_s_top=1;


  extern function new(string name="master_env_cfg");
 
 endclass
    
    
 function master_env_cfg::new(string name="master_env_cfg");
   super.new(name);

 endfunction
    
    `endif   
    
 ////////////////////master_env_cfg//////////////////////////   
    
    

