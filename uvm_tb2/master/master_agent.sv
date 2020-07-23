///////////////////master_agent///////////////////////////////////////

`ifndef master_agent_sv
`define master_agent_sv

 typedef class master_env_cfg;    
class master_agent extends uvm_agent;

  `uvm_component_utils(master_agent)
   
  
  //agent handles
  master_seqr m_seqr;
  master_drv m_drv;
  master_mon m_mon;
  

  //declaring m_cfg handle
  
 master_agent_cfg m_cfg[]; 
  
  master_env_cfg e_cfg;
  
  
  int i=0;
  
  
  extern function new(string name="m_agent",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
 // extern task run_phase(uvm_phase phase);
    
endclass
      
    
function master_agent::new(string name="m_agent",uvm_component parent);
  super.new(name,parent);
endfunction
    
 
 function void master_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   
   if(!uvm_config_db #(master_env_cfg)::get(this,"","e_cfg",e_cfg))
   begin
   
     `uvm_fatal(get_type_name(),"not getting env cfg hanlde in agent")
   end
   
  
   i=e_cfg.no_of_m_agent;
 
   
   
// get the config handle
   m_cfg=new[i];
   
   foreach(m_cfg[i])
   
  // for(int j=0;j<i;j++)  
   begin
     if(!uvm_config_db #(master_agent_cfg)::get(this,"","master_agent_cfg",e_cfg.m_cfg[i]))
   begin
   
     `uvm_fatal(get_type_name(),"not getting cfg hanlde in agent")
   end
     m_cfg[i]=master_agent_cfg::type_id::create($sformatf("master_agent_cfg[%0d]",i));  
       
       
    m_mon=master_mon::type_id::create("m_mon",this);    
  end
  
   
  
   foreach(m_cfg[i])
    begin
     if(m_cfg[i].is_active==UVM_ACTIVE)
 
   begin
      m_drv=master_drv::type_id::create("m_drv",this);
      m_seqr=master_seqr::type_id::create("m_seqr",this);
    end
   end

  
 endfunction
    
    
 function void master_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
   m_drv.seq_item_port.connect(m_seqr.seq_item_export);
 endfunction
  
  
    `endif
///////////////////master_agent///////////////////////////////////////  
  
    
