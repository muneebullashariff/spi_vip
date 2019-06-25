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

`ifndef _MASTER_DRIVER_
`define _MASTER_DRIVER_


//-----------------------------------------------------------------------------
// Class: master_driver
// Description of the class.
/*Driver is written by extending uvm_driver,uvm_driver is inherited from uvm_component, 
  Methods and TLM port (seq_item_port) are defined for communication between sequencer and driver,
  uvm_driver is a parameterized class and it is parameterized with the type of the request 
  sequence_item and the type of the response sequence_item*/ 
//------------------------------------------------------------------------------
class master_driver extends uvm_driver #(master_xtn);

/*register with factory so can use create uvm_method and override in
	future if necessary*/ 
 `uvm_component_utils(master_driver)

//declaring handle for master agent config class 

 master_agent_config m_cfg;

 //---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
 extern function new(string name = "master_driver", uvm_component parent); 
 extern function void build_phase(uvm_phase phase);
  //extern virtual task run_phase(uvm_phase phase);
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
	`uvm_fatal("TB CONFIG","cannot get() m_cfg from uvm_config");
  super.build_phase(phase);

endfunction: build_phase

`endif
