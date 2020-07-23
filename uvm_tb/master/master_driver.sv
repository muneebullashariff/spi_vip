//  ###########################################################################
//
//  Licensed to the Apache Software Foundation (ASF) under one
//  or more contributor license agreements.  See the NOTICE file
//  distributed with this work for additional information
//  regarding copyright ownership.  The ASF licenses this file
//  to you under the Apache License, Version 2.0 (the
//  "License"); you may not use this file except in compliance
//  with the License.  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.
//
//  ###########################################################################

`ifndef _MASTER_DRIVER_INCLUDED_
`define _MASTER_DRIVER_INCLUDED_


//-----------------------------------------------------------------------------
// Class: master_driver
// Description of the class.
//Driver is written by extending uvm_driver,uvm_driver is inherited from uvm_component, 
//Methods and TLM port (seq_item_port) are defined for communication between sequencer and driver,
//uvm_driver is a parameterized class and it is parameterized with the type of the request 
//sequence_item and the type of the response sequence_item 
//------------------------------------------------------------------------------

//`define vif m_vif.MDR_CB

class master_driver extends uvm_driver #(master_xtn);

//register with factory so can use create uvm_method and
// override in future if necessary 

 `uvm_component_utils(master_driver)

//declaring virtual interface
 virtual spi_if.MDR_CB vif;
  
 //  virtual spi_if m_vif; //v
 
 
//declaring handle for master agent config class 
 master_agent_config m_cfg;

//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
 extern function new(string name = "master_driver", uvm_component parent); 
 extern function void build_phase(uvm_phase phase);
 extern function void connect_phase(uvm_phase phase);
 extern virtual task run_phase(uvm_phase phase);
// extern virtual task clock_gen(master_xtn xtn);
  extern virtual task clock_gen();//v
  extern virtual task drive_to_dut(master_xtn req);//v
 extern virtual task data_trans(master_xtn xtn);

endclass: master_driver

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_driver class component
//
// Parameters:
//  name - instance name of the master_driver
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function master_driver::new(string name="master_driver", uvm_component parent); 
  super.new(name,parent); 
endfunction: new 

//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
function void master_driver::build_phase(uvm_phase phase);
  
      if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",m_cfg))
        begin
	`uvm_fatal("TB CONFIG","cannot get() m_cfg from uvm_config");
         end
  super.build_phase(phase);

endfunction: build_phase

//--------------------------------------------------------------------------------
//Function:connect phase

//connecting virtual interface with master agent config
//--------------------------------------------------------------------------------
 function void master_driver::connect_phase(uvm_phase phase);
	 vif=m_cfg.vif;
endfunction:connect_phase

//--------------------------------------------------------------------------------
//task :run phase
//getting the item from the sequence and giving acknowledgement as item done
//to sequence


//-------------------------------------------------------------------------------
task master_driver::run_phase(uvm_phase phase);

  // TODO: Need to have the reset task to reset the
  // required signals
  //fork
  //  reset_task();
  //join_none

  // resetting the values - temporarily
  vif.ss_n <= 1;
  vif.sclk <= 0;
  vif.mosi <= 0;

	forever begin
		seq_item_port.get_next_item(req);
    drive_to_dut(req);
		seq_item_port.item_done();
	end
endtask:run_phase

task master_driver::drive_to_dut(master_xtn req);
//task drive_to_dut(master_xtn req); //v
  // Asserting the chip-select 
  vif.ss_n <= 1'b0;
  
  // TODO: Need to have the delay parameterized
  #5; // half-clock cycle of spi

  fork
    clock_gen();
    data_trans(req);
  join
endtask: drive_to_dut

//-------------------------------------------------------------------------------
//task:clock gen
//generating the clock
//----------- ---------------------------------------------------------------------
task master_driver::clock_gen();
//task clock_gen(); //v


  // Generating 8 clock pulses - for 8bits
  for(int i=0; i<8; i++) begin
    #5; vif.sclk <= ~(vif.sclk); 
    #5; vif.sclk <= ~(vif.sclk); 
  end
endtask:clock_gen

//--------------------------------------------------------------------------------
//task:data_trans
//converting transaction level to pin level
//
//---------------------------------------------------------------------------------

task master_driver::data_trans(master_xtn xtn);
//task data_trans(master_xtn xtn); //v
 
 // Temporary mosi data
	bit [7:0] mosi_data;
  bit [7:0] miso_data;

  mosi_data = xtn.data_in_mosi;

  //for(int i=7;i<xtn.data_in_mosi;i--) begin
  //  xtn.data_in_mosi[7]=vif.MDR_CB.mosi;
  //  vif.mosi <= xtn.data_in_mosi[7];  
  //   $display("left shift operation",xtn.data_in_mosi >> 1'b1);
  //   vif.SDR_CB.miso=xtn.data_in_mosi;
  //  end
      
  fork
    begin: MOSI
      // mosi data driving on the interface  
      for(int i=0; i<8; i++) begin
        @(posedge vif.sclk);
        vif.mosi <= mosi_data[7];  
        mosi_data = mosi_data << 1;
      end
    end
    begin: MISO
      // miso data sampling from the interface
      for(int i=0; i<8; i++) begin
        @(negedge vif.sclk);
        miso_data = miso_data << 1; 
        miso_data[0] = vif.miso;
      end
    end
  join

  `uvm_info("master_driver",$sformatf("printin from master_driver \n %s",xtn.sprint()),UVM_LOW)
endtask:data_trans
//---------------------------------------------------------------------------------
`endif
	




