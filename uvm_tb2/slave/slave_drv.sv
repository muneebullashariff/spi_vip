    
 

`ifndef slave_drv_sv
`define slave_drv_sv


class slave_drv extends uvm_driver #(slave_trans);
       
 `uvm_component_utils(slave_drv) 
  virtual spi_if vif;
   
   bit [7:0] slv2m_data; 
  
  
   extern function new(string name="slave_drv",uvm_component parent); 
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);    
   extern task drive2dut();
   extern task clock_gen();    
   extern task drive();
    // extern function void mosi(); //additional
       extern function void miso(); //additional 
     
 endclass
 
   
 function slave_drv::new(string name="slave_drv",uvm_component parent);
   super.new(name,parent);
 endfunction
     
     function void slave_drv::build_phase(uvm_phase phase);
       super.build_phase(phase);
       if(!uvm_config_db #(virtual spi_if)::get(this,"","vif",vif))
       begin
          `uvm_fatal(get_type_name(),"interface in slave driver not found")
       end
     endfunction
     
     function void slave_drv::connect_phase(uvm_phase phase);
       super.connect_phase(phase);
     endfunction
     
     task slave_drv::run_phase(uvm_phase phase);
      super.run_phase(phase);
       
       vif.miso=1'b0;
       forever
         begin
           $display("in driver,next_item");
           seq_item_port.get_next_item(req);
           $display("in driver,ready to drive");
       drive2dut();
       seq_item_port.item_done();
         end
       
       
     endtask
     
     
     task slave_drv::drive2dut();
       
      
       
       bit check;
     //  bit [7:0] q[$];
       
       slv2m_data=req.data_trans;
      
     
      for(int i=0;i<8;i++)
        begin
          
         if(req.cpol==1'b0)
            begin
          
          @(negedge vif.sclk);
     
          
          vif.ss_n<=req.ss_n;
          
          
       
          `uvm_info(get_type_name(),$sformatf("IN SLAVE DRIVER BEFORE SHIFTING,slv2m_data=%b,vif.miso=%b,check=%b",slv2m_data,vif.miso,check),UVM_HIGH)
          
          vif.miso<=slv2m_data[0];
            
         
          
          slv2m_data=slv2m_data>>1;
             
          
`uvm_info(get_type_name(),$sformatf("IN SLAVE DRIVER AFTER SHIFTING,slv2m_data=%b,vif.miso=%b,check=%b",slv2m_data,vif.miso,check),UVM_HIGH)
          
          #1;
      
          
            end //if       

   
        if(req.cpol==1'b1)
            begin
          
          @(posedge vif.sclk);
     
          
          vif.ss_n<=req.ss_n;
          
          
       
          `uvm_info(get_type_name(),$sformatf("IN SLAVE DRIVER BEFORE SHIFTING,slv2m_data=%b,vif.miso=%b,check=%b",slv2m_data,vif.miso,check),UVM_LOW)
          
          vif.miso<=slv2m_data[0];
            
         
          
          slv2m_data=slv2m_data>>1;
             
          
`uvm_info(get_type_name(),$sformatf("IN SLAVE DRIVER AFTER SHIFTING,slv2m_data=%b,vif.miso=%b,check=%b",slv2m_data,vif.miso,check),UVM_LOW)
          
          #1;
      
          
        end //if       


        
        end //for
 
     endtask
         
         
         
         `endif     
         
 /////////////////slave_drv/////////////////////////////////

