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

`ifndef _MASTER_MONITOR_
`define _MASTER_MONITOR_


//-----------------------------------------------------------------------------
// Class: master_monitor
// Description of the class.
/*Monitor is written by extending uvm_monitor,uvm_monitor is inherited from uvm_component, 
	A monitor is a passive entity that samples the DUT signals through virtual interface and 
	converts the signal level activity to transaction level,monitor samples DUT signals but does not drive them.
	Monitor should have analysis port (TLM port) and virtual interface handle that points to DUT signals*/
//------------------------------------------------------------------------------
class master_monitor extends uvm_monitor;

/*register with factory so can use create uvm_method and override in
	future if necessary*/ 
 `uvm_component_utils(master_monitor)

//declaring handle for master config class 

 master_agent_config m_cfg;

//declaring analysis port for the monitor port
uvm_analysis_port #(master_xtn)monitor_port;

//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
 extern function new(string name = "master_monitor", uvm_component parent); 
 extern function void build_phase(uvm_phase phase);
  //extern virtual task run_phase(uvm_phase phase);
endclass: master_monitor

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_monitor class component
//
// Parameters:
//  name - instance name of the config_template
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function master_monitor::new(string name="master_monitor", uvm_component parent); 
  super.new(name,parent); 

//creating monitor port
monitor_port=new("monitor_port",this);

endfunction: new 

//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
function void master_monitor::build_phase(uvm_phase phase);

    super.build_phase(phase);

  
      if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",m_cfg))
	`uvm_fatal("TB CONFIG","cannot get() m_cfg from uvm_config");
 
endfunction: build_phase

`endif
