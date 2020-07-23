 /////////////////master_drv/////////////////////////////////

`ifndef master_drv_sv
`define master_drv_sv

 class master_drv extends uvm_driver #(master_trans);
       
 `uvm_component_utils(master_drv) 
  virtual spi_if vif;
   
  master_trans req;
   
   
   extern function new(string name="master_drv",uvm_component parent); 
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);    
   extern task drive2dut();
   extern task clock_gen();    
   extern task drive();
   extern function void mosi(); //additional
   extern function void miso(); //additional 
     
         
     
   extern task clock_polarity();      
         
         
 endclass
 
   
 function master_drv::new(string name="master_drv",uvm_component parent);
   super.new(name,parent);
 endfunction
     
     function void master_drv::build_phase(uvm_phase phase);
       super.build_phase(phase);
       if(!uvm_config_db #(virtual spi_if)::get(this,"","vif",vif))
       begin
          `uvm_fatal(get_type_name(),"interface in master driver not found")
       end
     endfunction
     
     function void master_drv::connect_phase(uvm_phase phase);
       super.connect_phase(phase);
     endfunction
     
     
  task master_drv::clock_polarity();

  if(req.cpol==0)
    vif.sclk=1'b0;  //positve edge
  
  if(req.cpol==1)
    vif.sclk=1'b1;  //negative edge
  
endtask
     
     
     
     
     
     task master_drv::run_phase(uvm_phase phase);
      // super.run_phase(phase);
       forever
         begin
           $display("in driver,next_item");
           seq_item_port.get_next_item(req);
           $display("in driver,ready to drive");
       drive2dut();
       seq_item_port.item_done();
         end
       
       
     endtask
     
     
     task master_drv::drive2dut();
       vif.master_drv_cb.ss_n<=1'b0;
    //   #1; //dont know the importance of it,yet
       $display("in drive to dut");
       //add_delay
       
       fork
         $display("in fork join");
         begin
         clock_gen();
         end
         
         begin
           drive();
         end
       join
      
       
       
     endtask //drive2dut
     
     task master_drv::clock_gen();
       bit iclk;
    
    
       clock_polarity();
       
       for(int i=0;i<8;i++) 
    //   forever
         begin
          
          
          #1 iclk=~iclk;
           vif.sclk<=iclk; 
          #1 iclk=~iclk; 
           vif.sclk<=iclk;
           
         end
           
     
       
     endtask
     
     task master_drv::drive();
       
      
       bit [7:0] miso_data;
       bit [7:0] mosi_data;
       
       mosi_data=req.data_trans; 
       
      
       
    
         begin:mosi
           $display("in mosi");
      
       forever
       begin
        if(req.cpol==1'b0 || req.cpol==1'b1)
  begin
    
    if(req.cpha==1'b0)
      begin
        @(posedge vif.sclk);
        
      //  $display("sampling at posedge");
        
         vif.ss_n<=req.ss_n;
     
        `uvm_info(get_type_name(),$sformatf("MASTER****BEFORE SHIFTING IN MASTER DRIVER,mosi_data=%b",mosi_data),UVM_LOW)  
         vif.mosi<=mosi_data[7];
         mosi_data=mosi_data<<1;
     
         
        `uvm_info(get_type_name(),$sformatf("MASTER****IN MASTER DRIVER,mosi_data=%b",mosi_data),UVM_LOW)    
         if(mosi_data==8'b00000000)
           break;
         
      end  
    
    if(req.cpha==1'b1)
      begin
        @(negedge vif.sclk);
        
        $display("sampling at negedge");
        
         vif.ss_n<=req.ss_n;
     
         `uvm_info(get_type_name(),$sformatf("BEFORE SHIFTING IN MASTER DRIVER,mosi_data=%b",mosi_data),UVM_LOW)  
         vif.mosi<=mosi_data[7];
         mosi_data=mosi_data<<1;
     
         
         `uvm_info(get_type_name(),$sformatf("IN MASTER DRIVER,mosi_data=%b",mosi_data),UVM_LOW)    
         if(mosi_data==8'b00000000)
           break;
          
        
      end
    
  end
    
 end 
           
 end :mosi        
           
           
             
      
 endtask //drive
     

 /////////////////master_drv/////////////////////////////////

         `endif
