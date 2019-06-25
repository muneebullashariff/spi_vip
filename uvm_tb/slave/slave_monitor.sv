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

`ifndef _SLAVE_MONITOR_
`define _SLAVE_MONITOR_


//3) Use of comments and code as per the coding guidelines

//-----------------------------------------------------------------------------
// Class: SLAVE_MONITOR
// Description of the class.
// This class collects data from dut and transmits it to the scoreboard
// through analysis port

//-----------------------------------------------------------------------------
class slave_monitor extends uvm_monitor;

  `uvm_component_utils(slave_monitor)

  //declaring the handles of virtual interface and slave agent config and
  //analysis port
   // virtual spi_if.SLAVE_MON_MP vif;
  	slave_agent_config s_cfg;

	uvm_analysis_port #(slave_xtn) monitor_port;



   //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------
  extern function new(string name="slave_monitor", uvm_component parent); 
  extern virtual function void build_phase(uvm_phase phase);
//  extern virtual function void connect_phase(uvm_phase phase);
 // extern virtual task run_phase(uvm_phase phase);
  //extern virtual task collect_data;


 endclass: slave_monitor


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_monitor class component
//
// Parameters:
//  name - instance name of the slave_monitor
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function slave_monitor::new(string name="slave_monitor", uvm_component parent); 
  super.new(name,parent); 

 monitor_port=new("monitor_port",this);

endfunction: new 

//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
function void slave_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);

        if(!uvm_config_db #(slave_agent_config)::get(this,"","slave_agent_config",s_cfg))
	begin
	  `uvm_fatal("CONFIG","Cannot get() s_cfg from uvm_config_db.Have you set it?")
	end
	

 
 endfunction: build_phase
/*//-----------------------------------------------------------------------------
// Function: connect_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------

function void slave_mon::connect_phase(uvm_phase phase);
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
  collect_data();
 endtask: run_phase

//-----------------------------------------------------------------------------
// Task: send_to_dut
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------

task slave_mon::collect_data;



`uvm_info("SLAVE_monitor",$sformatf("printing from monitor \n %s", xtn.sprint()),UVM_LOW) 

		endtask


    
//4) Close of Include guard*/
`endif
