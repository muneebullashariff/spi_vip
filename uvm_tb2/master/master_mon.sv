`ifndef master_mon_sv
`define master_mon_sv

class master_mon extends uvm_monitor;
       
  `uvm_component_utils(master_mon)
  virtual spi_if vif;
  
  uvm_analysis_port #(master_trans) m_mon2sb;
  
  
  master_trans trans_h;
  
   bit [7:0] slv2m_data;
       
  // bit [9:0] q[$];
       
    //   bit check;
  
  
   extern function new(string name="master_mon",uvm_component parent); 
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);    
  
   extern task monitor();  
     
 endclass
 
     
 function master_mon::new(string name="master_mon",uvm_component parent);
   super.new(name,parent);
   m_mon2sb=new("m_mon2sb",this);
   
 endfunction
     
 function void master_mon::build_phase(uvm_phase phase);
    super.build_phase(phase);
       
    trans_h=master_trans::type_id::create("trans_h");
    
   
   if(!uvm_config_db #(virtual spi_if)::get(this,"","vif",vif))
       begin
         `uvm_fatal(get_type_name(),"interface in master monitor not found")
       end   
  endfunction
     
  function void master_mon::connect_phase(uvm_phase phase);
     super.connect_phase(phase);
  endfunction
     
  task master_mon::run_phase(uvm_phase phase);
     super.run_phase(phase);
    
    
    //process to add here for taking the signal values fro interface and putting onto packet
    forever
      begin
      
      //  $display("in master monitor");
     // #1
        monitor();
      
      end
    

    
    m_mon2sb.write(trans_h); //sending the packet to sb for comparision by using analysis port
    
    `uvm_info("IN MASTER_MONITOR",$sformatf("the data onto monitor is %s",trans_h.sprint()),UVM_HIGH)  
  endtask
     
     
  task master_mon::monitor();
 
       master_trans trans_h;
  
       trans_h=master_trans::type_id::create("trans_h");
  
       
       
       @(negedge vif.sclk);
  //  @(vif.miso);
       begin
   
             
             trans_h.ss_n=vif.ss_n;             
             slv2m_data[0]=vif.miso;
             slv2m_data=slv2m_data<<1;
      
         //    q.push_back(check);
            
          
             
         `uvm_info(get_type_name(),$sformatf("IN MASTER_MONITOR ,slv2mon_data=%b",slv2m_data),UVM_LOW)    
      #1;  
      
       end
       
    
     endtask
     
     
     `endif    
     
     
     
     
///////////////////master_mon///////////////////////////////////////
     
     
