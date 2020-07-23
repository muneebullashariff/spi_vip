////////////////////////////////virtual_sequencer////////////////////////////////////

`ifndef virtual_sequencer_sv
`define virtual_sequencer_sv

class virtual_sequencer extends uvm_sequencer;
  
  `uvm_component_utils(virtual_sequencer)
  
  master_seqr m_seqr; //target_sequencer handle
  //master_env m_env; 
  slave_seqr s_seqr;
 
  
  
  
  extern function new(string name="v_seqr",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
//extern function void connect_phase(uvm_phase phase);    
  
 endclass
  
    
    function virtual_sequencer::new(string name="v_seqr",uvm_component parent);
      super.new(name,parent);
    endfunction
    
    
    function void virtual_sequencer::build_phase(uvm_phase phase);
      super.build_phase(phase);
    
    endfunction
  
    
    `endif  

//////////////////////////////////virtual_sequence//////////////////////////////////////

