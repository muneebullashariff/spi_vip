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

`ifndef _MASTER_AGENT_
`define _MASTER_AGENT_


//-----------------------------------------------------------------------------
// Class: master_agent
// Description of the class.
/*agent is container called universal verification component that contain driver,
	monitor,sequencer*/
//------------------------------------------------------------------------------
class master_agent extends uvm_agent;

/*register with factory so can use create uvm_method and override in
	future if necessary*/ 
 `uvm_component_utils(master_agent)

//declaring handle for master config class,master driver
//master monitor and master sequencer 

 master_agent_config  m_cfg;
 master_driver  m_drv;
 master_monitor  m_mon;
 master_sequencer m_seqr;

   //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------
  extern function new(string name = "master_agent", uvm_component parent); 
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass: master_agent

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_agent class component
//
// Parameters:
//  name - instance name of the config_template
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function master_agent::new(string name="master_agent", uvm_component parent); 
  super.new(name,parent); 
endfunction: new 

//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//-----------------------------------------------------------------------------
function void master_agent::build_phase(uvm_phase phase);
 super.build_phase(phase);

  
      if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",m_cfg))
	`uvm_fatal("TB CONFIG","cannot get() m_cfg from uvm_config");

 //creating master monitor
      m_mon=master_monitor::type_id::create("m_mon",this);
       m_cfg=new();

/*If the master agent is made active in master_configuration class create
	driver and sequencer*/
 if(m_cfg.is_active==UVM_ACTIVE)
  begin
   m_drv=master_driver::type_id::create("m_drv",this);
   m_seqr=master_sequencer::type_id::create("m_seqr",this);
  end


 
endfunction: build_phase
//--------------------------------------------------------------------
//Function:connect phase
//connectiong the master driver sequence item port to master sequencer sequence item export
function void master_agent::connect_phase(uvm_phase phase);
   if(m_cfg.is_active==UVM_ACTIVE)
    begin
     m_drv.seq_item_port.connect(m_seqr.seq_item_export);
      end
endfunction:connect_phase

`endif
