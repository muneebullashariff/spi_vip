`ifndef master_trans_sv
`define master_trans_sv

class master_trans extends uvm_sequence_item;

  `uvm_object_utils(master_trans)
  
  rand bit [1:0]cpol;
  rand bit [1:0]cpha;
  
  rand bit [7:0] data_trans;
  rand bit mosi;
  bit miso;
  bit ss_n;
  bit sclk;
  
  master_trans trans;
    
  extern function new(string name="master_trans");
  //extern function void do_copy(uvm_object rhs);
    
    
 endclass

  
  function master_trans::new(string name="master_trans");
    super.new(name);
   // trans=master_trans::type_id::create("trans");
    
  endfunction
  
  /*  
    function void master_trans::do_copy(uvm_object rhs);
      super.do_copy(rhs);
      master_trans trans;
   
   //rhs of type seq_item,obj of type uvm_object,both belong to same family ,we cannot make direct assignment,so we will use casting method  
   
      if(!$cast(trans,rhs)) 
     `uvm_info("copy_fail",UVM_LOW)
   else
     begin
   mosi=trans.mosi;
   miso=trans.miso;
   ss=trans.ss;
   data_trans=trans.data_trans;
     end
   
 endfunction
    */  

    `endif   
 ////////////////master_transaction/////////////////////   
    
