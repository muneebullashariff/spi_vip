`ifndef master_env_sv
`define master_env_sv    

class master_env extends uvm_env;

   `uvm_component_utils(master_env)
   
   master_agent_top mtop;
   
   slave_agent_top stop;
  
  // master_agent m_ag;
   master_sb m_sb;
   
   virtual_sequencer v_seqr;
   master_env_cfg e_cfg;
   
   
  extern function new(string name="master_env",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
    
 endclass 
   
  
  function master_env::new(string name="master_env",uvm_component parent);
  super.new(name,parent);
  endfunction
    
 
 function void master_env::build_phase(uvm_phase phase);
   super.build_phase(phase);
   
   
   if(!uvm_config_db #(master_env_cfg)::get(this,"","e_cfg",e_cfg))
      begin
      `uvm_fatal(get_type_name(),"unable to get e_cfg in virtual_seq")
      end
   
   
   
   
   if(e_cfg.has_m_top==1)
   mtop=master_agent_top::type_id::create("m_ag_top",this);
  // m_ag=master_agent::type_id::create("m_ag",this);
   
   
   if(e_cfg.has_s_top==1)
     stop=slave_agent_top::type_id::create("s_ag_top",this);
   
   
   if(e_cfg.has_scoreboard==1)
   m_sb=master_sb::type_id::create("m_sb",this);
   
   if(e_cfg.has_virtual_sequencer==1)
     v_seqr=virtual_sequencer::type_id::create("v_seqr",this);
   
   
 endfunction
    
    
 function void master_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
   
  //for master
   
   if(e_cfg.has_virtual_sequencer)
     begin
       if(e_cfg.has_m_top)
         begin
           for(int i=0;i<e_cfg.no_of_m_agent;i++)
             begin
   
               v_seqr.m_seqr=mtop.m_agent[i].m_seqr;
  
             end
         end
       
       
    //for slave
       
       if(e_cfg.has_s_top)
         begin
           for(int i=0;i<e_cfg.no_of_s_agent;i++)
             begin
   
               v_seqr.s_seqr=stop.s_agent[i].s_seqr;
  
             end
         end
   
       
     end
 endfunction

     
 task master_env::run_phase(uvm_phase phase);
    super.run_phase(phase);
  
 endtask
      
   
///////////////////master_env///////////////////////////////////////
    
    `endif  
      
   
