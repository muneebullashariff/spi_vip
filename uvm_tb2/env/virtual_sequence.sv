
/////////////////////////virtual_sequence/////////////////////////////////


`ifndef virtual_sequence_sv
`define virtual_sequence_sv


`include "virtual_sequencer.sv"
`include "master_seq.sv"

`include "slave_seq.sv"
;
    
class base_sequence extends uvm_sequence;
  
  `uvm_object_utils(base_sequence)
  
   virtual_sequencer v_seqr;
  
   master_seqr m_seqr;
  
   master_env_cfg e_cfg; 
  
   slave_seqr s_seqr;

  
  extern function new(string name="base_sequence");
   
  extern task body();  
    
endclass
    
      
 function base_sequence::new(string name="base_sequence");   
   super.new(name);
 endfunction
      
      
 task base_sequence::body();
 
   if(!$cast(v_seqr,m_sequencer))
     begin
     `uvm_fatal(get_type_name(),"virtual seqr pointer cast failed")
     end

   
   m_seqr=v_seqr.m_seqr;
   
   s_seqr=v_seqr.s_seqr;
   
 endtask

    
  
class virtual_sequence extends base_sequence;
  
  
  `uvm_object_utils(virtual_sequence);
  
  
   master_write_seq mw_seq;
  
   slave_select_seq ss_seq; //slave_seq
  
  master_env_cfg e_cfg;
  
  
  extern function new(string name="v_sequence");
    
  extern task body();    
    
endclass
    
    
 function virtual_sequence::new(string name="v_sequence");   
   super.new(name);
 endfunction   
    
 task virtual_sequence::body();
  
   super.body; 
   

   mw_seq=master_write_seq::type_id::create("mw_seq");
   
   
   ss_seq=slave_select_seq::type_id::create("ss_seq");
    
   
   fork
     
   mw_seq.start(m_seqr);
   
   ss_seq.start(s_seqr);
    
   join
   
   
 endtask
   
    `endif   
    
////////////////////////////////virtual_sequence//////////////////////////////////
    

