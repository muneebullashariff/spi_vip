

`ifndef slave_seq_sv
`define slave_seq_sv

 class slave_seq extends uvm_sequence #(slave_trans);
        
   `uvm_object_utils(slave_seq) 
   
   extern function new(string name="slave_seq");
   extern task body();
       
 endclass
     
 function slave_seq::new(string name="slave_seq");
    super.new(name);
 endfunction
     
 task slave_seq::body();
   
   req=slave_trans::type_id::create("req");
   wait_for_grant();
   assert(req.randomize());
   send_request(req);
   wait_for_item_done();
        
 endtask
     
     
     
  class slave_select_seq extends slave_seq;
     
    `uvm_object_utils(slave_select_seq)
   
    extern function new(string name="slave_select_seq");
   extern task body();
       
 endclass
     
     function slave_select_seq::new(string name="slave_select_seq");
    super.new(name);
 endfunction
     
 task slave_select_seq::body();
  
  
   `uvm_do_with(req,{req.data_trans==8'b10101010;req.ss_n==1'b0;req.cpol==1'b0;})
   
  // `uvm_info(get_type_name(),$sformatf("packet in slave %s",req.sprint()),UVM_LOW)
   
  // `uvm_info(get_type_name(),$sformatf("packet ins slave ss_n=%b,data_trans=%b",req.ss_n,req.data_trans),UVM_LOW)
   
//   `uvm_do_with(req,{req.data_trans_master==8'b11110000;req.mosi==1'b1;req.cpol==0;req.cpha==0;})
   
   
 endtask
     
     
  `endif
     
     
