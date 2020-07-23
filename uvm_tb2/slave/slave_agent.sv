

`ifndef slave_agent_sv
`define slave_agent_sv

 typedef class master_env_cfg;    
class slave_agent extends uvm_agent;

  `uvm_component_utils(slave_agent)
   
  
  //agent handles
  slave_seqr s_seqr;
  slave_drv s_drv;
  slave_mon s_mon;
  

  //declaring m_cfg handle
 // slave_agent_cfg m_cfg;
  
 slave_agent_cfg s_cfg[]; 

  
 master_env_cfg e_cfg; //there is only one handle for env_cfg
  
  
  int i=0;
  
  
  extern function new(string name="s_agent",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
 // extern task run_phase(uvm_phase phase);
    
endclass
      
    
function slave_agent::new(string name="s_agent",uvm_component parent);
  super.new(name,parent);
endfunction
    
 
 function void slave_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   
   if(!uvm_config_db #(master_env_cfg)::get(this,"","e_cfg",e_cfg))
   begin
   
     `uvm_fatal(get_type_name(),"not getting env cfg hanlde in agent")
   end
   
   //
   i=e_cfg.no_of_s_agent;
  
   
// get the config handle
   s_cfg=new[i];
   
   foreach(s_cfg[i])
   
  // for(int j=0;j<i;j++)  
   begin
     if(!uvm_config_db #(slave_agent_cfg)::get(this,"","slave_agent_cfg",e_cfg.s_cfg[i]))
   begin
   
     `uvm_fatal(get_type_name(),"not getting cfg hanlde in agent")
   end
     s_cfg[i]=slave_agent_cfg::type_id::create($sformatf("slave_agent_cfg[%0d]",i));  
  
    s_mon=slave_mon::type_id::create("s_mon",this);    
  end
  
  
   foreach(s_cfg[i])
     begin
     if(s_cfg[i].is_active==UVM_ACTIVE)
  
   begin
      s_drv=slave_drv::type_id::create("s_drv",this);
     s_seqr=slave_seqr::type_id::create("s_seqr",this);
   end
     end
 
  
 endfunction
    
    
 function void slave_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
   s_drv.seq_item_port.connect(s_seqr.seq_item_export);
 endfunction
  
    `endif
  
///////////////////slave_agent///////////////////////////////////////  
  
