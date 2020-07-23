    
///////////////////master_scoreboard///////////////////////////////////////  

`ifndef master_sb_sv
`define master_sb_sv

class master_sb extends uvm_scoreboard;   

  `uvm_component_utils(master_sb)
  
//  uvm_analysis_imp #(master_trans,master_sb) sb2mon;
  
  
  //external function
  extern function new(string name="m_sb",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
    
  //extern write function
 //   extern function void write (master_trans m_trans); 
  
 endclass
  
 
     
function master_sb::new(string name="m_sb",uvm_component parent);
  super.new(name,parent);
 // sb2mon=new("sb2mon",this);
endfunction
    
 
 function void master_sb::build_phase(uvm_phase phase);
   super.build_phase(phase);
   
 endfunction
    
    
 function void master_sb::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  
 endfunction
   
/*    
 ///add the function     
 function void master_sb::write(master_trans m_trans);
        
 endfunction 
  */
      
     
 task master_sb::run_phase(uvm_phase phase);
    super.run_phase(phase);
  
 endtask
   
    `endif  
    
 ///////////////////master_sb///////////////////////////////////////   
    

