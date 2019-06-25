//1) License copy
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

`ifndef _SLAVE_DRIVER_INCLUDED
`define _SLAVE_DRIVER_INCLUDED



//-----------------------------------------------------------------------------
// Class: slave_driver
// Description of the class.
// This class provides the conversion of transaction level to pin level
//-----------------------------------------------------------------------------
class slave_driver extends uvm_driver #(slave_xtn);


  `uvm_component_utils(slave_driver)

  //declaring the handles of virtual interface and slave agent config 
   // virtual spi_if.SLAVE_DRV_MP vif;
  slave_agent_config s_cfg;

   //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------
  extern function new(string name="slave_driver", uvm_component parent); 
  extern function void build_phase(uvm_phase phase);
 // extern virtual function void connect_phase(uvm_phase phase);
  //extern virtual task run_phase(uvm_phase phase);
  //extern virtual task send_to_dut(slave_txn xtn);


 endclass: slave_driver


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_driver class component
//
// Parameters:
//  name - instance name of the slave_driver
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function slave_driver::new(string name="slave_driver", uvm_component parent); 
  super.new(name,parent); 
endfunction: new 

//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
function void slave_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);

        if(!uvm_config_db #(slave_agent_config)::get(this,"","slave_agent_config",s_cfg))
		begin
	 `uvm_fatal("CONFIG","Cannot get() s_cfg fron uvm_config_db. have you set it?")
		end


 endfunction: build_phase
//-----------------------------------------------------------------------------
// Function: connect_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------

/*function void slave_drv::connect_phase(uvm_phase phase);
	vif=s_cfg.vif;
endfunction

//-----------------------------------------------------------------------------
// Task: run_phase
// Waits for reset and initiates the main montoring task 
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
task slave_drv::run_phase(uvm_phase phase);
  forever
  	begin
  seq_item_port.get_next_item(req);
  		send_to_dut(req);
  seq_item_port.item_done();

 endtask: run_phase

//-----------------------------------------------------------------------------
// Task: send_to_dut
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------

task slave_drv::send_to_dut(slave_txn xtn)


`uvm_info("SLAVE_DRIVER",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_LOW) 

		endtask


    
//4) Close of Include guard*/
`endif
