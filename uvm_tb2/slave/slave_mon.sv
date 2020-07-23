 

`ifndef slave_mon_sv
`define slave_mon_sv

class slave_mon extends uvm_monitor;
       
  `uvm_component_utils(slave_mon)
  virtual spi_if vif;
  
  uvm_analysis_port #(slave_trans) s_mon2sb;
  
  slave_trans s_trans; //slave_transaction
  
  
   bit [7:0] m2slv_data;
    
    bit q[$];
  
  
   extern function new(string name="slave_mon",uvm_component parent); 
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);    
   extern task monitor();
     
     
 endclass
 
     
 function slave_mon::new(string name="slave_mon",uvm_component parent);
   super.new(name,parent);
   s_mon2sb=new("s_mon2sb",this);
   
 endfunction
     
 function void slave_mon::build_phase(uvm_phase phase);
    super.build_phase(phase);
    s_trans=slave_trans::type_id::create("s_trans");
       
   if(!uvm_config_db #(virtual spi_if)::get(this,"","vif",vif))
       begin
         `uvm_fatal(get_type_name(),"interface in slave monitor not found")
       end   
  endfunction
     
  function void slave_mon::connect_phase(uvm_phase phase);
     super.connect_phase(phase);
  endfunction
     
  task slave_mon::run_phase(uvm_phase phase);
     super.run_phase(phase);
    
     forever
       begin
         monitor();
       end
    
    
    
    //process to add here for taking the signal values fro interface and putting onto packet
  
   
    
    
    
    s_mon2sb.write(s_trans); //sending the packet to sb for comparision by using analysis port
    
  endtask
     
     
  task slave_mon::monitor();
 
   
    
   // @(posedge vif.sclk);
    @(vif.mosi);
    
       #1;
      
  
              s_trans.ss_n=vif.ss_n;
              m2slv_data[0]=vif.mosi; //get_the_data
    
              m2slv_data=m2slv_data<< 1; //shift_the_data
          //    m2slv_data=vif.mosi;
              
   // q.push_back(m2slv_data);
    
    `uvm_info(get_type_name(),$sformatf("IN SLAVE MON,slav_sel=%b,slave_data=%b",s_trans.ss_n,m2slv_data),UVM_LOW)
    
    
  endtask
 
     
     `endif  
     
///////////////////slave_mon///////////////////////////////////////
     
     
