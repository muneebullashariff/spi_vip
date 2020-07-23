
`ifndef slave_trans_sv
`define slave_trans_sv

class slave_trans extends uvm_sequence_item;

  `uvm_object_utils(slave_trans)
  
  rand bit [1:0]cpol; //only this bit will effect the slave
  bit [1:0]cpha;
  
  rand bit [7:0] data_trans;
  bit[7:0] data_trans_master;
  bit miso;
  bit mosi;
  rand bit ss_n; //selecting slave depends on slave select
  bit sclk;
  
  slave_trans trans;
    
  extern function new(string name="slave_trans");
      
 endclass

  
  function slave_trans::new(string name="slave_trans");
    super.new(name);
  
  endfunction
  
    `endif
