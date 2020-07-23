`ifndef master_seq_sv
`define master_seq_sv


///////////////master_sequence//////////////////////////   
 class master_seq extends uvm_sequence #(master_trans);
        
   `uvm_object_utils(master_seq) 
   
   extern function new(string name="master_seq");
   extern task body();
       
 endclass
     
 function master_seq::new(string name="master_seq");
    super.new(name);
 endfunction
     
 task master_seq::body();
   
  /*  
   req=master_trans::type_id::create("m_trans");
   start_item(req);
   void'(req.randomize());
   finish_item(req);
   */
   
   req=master_trans::type_id::create("req");
   wait_for_grant();
   assert(req.randomize());
   send_request(req);
   wait_for_item_done();
   
   
       
 endtask
     
  class master_write_seq extends master_seq;
     
   `uvm_object_utils(master_write_seq)
   
    extern function new(string name="master_write_seq");
   extern task body();
       
 endclass
     
 function master_write_seq::new(string name="master_write_seq");
    super.new(name);
 endfunction
     
 task master_write_seq::body();
   
   
   
   
   
   `uvm_do_with(req,{req.data_trans==8'b10101010;req.mosi==1'b1;req.cpol==0;req.cpha==0;})
   
   
//   `uvm_do_with(req,{req.data_trans==8'b00001111;req.mosi==1'b1;req.cpol==0;req.cpha==0;req.ss_n==1;})
   
   
 endtask
     
     
        
     
      `endif

